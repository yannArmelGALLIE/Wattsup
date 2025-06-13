from rest_framework import viewsets, status
from rest_framework.response  import Response
from rest_framework.decorators import api_view
from django.utils import timezone
from .models import Utilisateur, Compteur, Mesure , Prise, Alert, HistoriqueConsommation, ChatMessage
from .serializers import UtilisateurSerializer, CompteurSerializer, MesureSerializer, PriseSerializer, AlertSerializer, HistoriqueConsommationSerializer, ChatMessageSerializer

class UtilisateurViewSet(viewsets.ModelViewSet):
    queryset = Utilisateur.objects.all()
    serializer_class = UtilisateurSerializer

class CompteurViewSet(viewsets.ModelViewSet):
    queryset = Compteur.objects.all()
    serializer_class = CompteurSerializer

class MesureViewSet(viewsets.ModelViewSet):
    queryset = Mesure.objects.all()
    serializer_class = MesureSerializer


class PriseViewSet(viewsets.ModelViewSet):
    queryset = Prise.objects.all()
    serializer_class = PriseSerializer

class AlertViewSet(viewsets.ModelViewSet):
    queryset = Alert.objects.all()
    serializer_class = AlertSerializer

class HistoriqueConsommationViewSet(viewsets.ModelViewSet):
    queryset = HistoriqueConsommation.objects.all()
    serializer_class = HistoriqueConsommationSerializer


@api_view(['POST'])
def recevoir_mesure(request):
    try:
        identifiant_prise = int(request.data.get('prise_id'))
        tension = float(request.data.get('tension'))
        courant = float(request.data.get('courant'))
        puissance = float(request.data.get('puissance'))

        prise = Prise.objects.get(identifiant=identifiant_prise)

        mesure = Mesure.objects.create(
            compteur=prise.compteur,
            tension=tension,
            courant=courant,
            puissance=puissance
        )

        if puissance > 3000:
            Alert.objects.create(
                prise=prise,
                type='SURCONSO',
                message=f"Surconsommation détectée : {puissance}W"
            )

        if puissance <= 1 or courant < 0.01:
            Alert.objects.create(
                prise=prise,
                type='COUPURE',
                message=f"Coupure de courant détectée à {timezone.now().strftime('%H:%M')}"
            )

        jour = timezone.now().date()
        historique, _ = HistoriqueConsommation.objects.get_or_create(
            compteur=prise.compteur, date=jour, defaults={'conso_heure': 0, 'conso_journaliere': 0}
        )
        historique.conso_heure += puissance / 60
        historique.save()

        return Response({"message": "Mesure enregistrée."}, status=status.HTTP_201_CREATED)

    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)


# Ajoutez ces imports et vues à votre views.py

import google.generativeai as genai
import json
from django.db.models import Avg, Sum
from datetime import datetime, timedelta
from django.conf import settings

# Configuration Gemini (ajoutez GEMINI_API_KEY dans settings.py)
genai.configure(api_key=settings.GEMINI_API_KEY)

class ChatMessageViewSet(viewsets.ModelViewSet):
    queryset = ChatMessage.objects.all()
    serializer_class = ChatMessageSerializer
    
    def get_queryset(self):
        utilisateur_id = self.request.query_params.get('utilisateur_id')
        if utilisateur_id:
            return ChatMessage.objects.filter(utilisateur_id=utilisateur_id)
        return super().get_queryset()

@api_view(['POST'])
def chat_with_bot(request):
    try:
        # Debug : afficher ce qui est reçu
        print("Content-Type:", request.content_type)
        print("Raw data:", request.body)
        print("Parsed data:", request.data)
        
        utilisateur_id = request.data.get('utilisateur_id')
        message_user = request.data.get('message')
        
        # Vérifications
        if not utilisateur_id:
            return Response(
                {"error": "utilisateur_id manquant"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
            
        if not message_user:
            return Response(
                {"error": "message manquant"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Vérifier si l'utilisateur existe
        try:
            utilisateur = Utilisateur.objects.get(identifiant=utilisateur_id)
        except Utilisateur.DoesNotExist:
            return Response(
                {"error": f"Utilisateur avec ID {utilisateur_id} non trouvé"}, 
                status=status.HTTP_404_NOT_FOUND
            )
        
        # ✅ NOUVELLE PARTIE - Génération de la réponse IA
        try:
            # Récupérer le contexte utilisateur
            context = get_user_context(utilisateur)
            
            # Générer la réponse avec l'IA
            bot_response = generate_bot_response(message_user, context)
            
        except Exception as e:
            # ⚠️ Fallback en cas d'erreur avec l'IA
            print(f"Erreur IA: {e}")
            bot_response = f"Bonjour {utilisateur.prenom}! Je rencontre un problème technique avec l'IA. Votre message: '{message_user}'"
        
        # Sauvegarder les messages
        try:
            ChatMessage.objects.create(
                utilisateur=utilisateur,
                message=message_user,
                sender='USER'
            )
            
            ChatMessage.objects.create(
                utilisateur=utilisateur,
                message=bot_response,
                sender='BOT'
            )
        except Exception as e:
            print("Erreur sauvegarde:", e)
        
        return Response({
            "user_message": message_user,
            "bot_response": bot_response,
            "timestamp": timezone.now(),
            "utilisateur": f"{utilisateur.prenom} {utilisateur.nom}"
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        print("Erreur complète:", str(e))
        return Response(
            {"error": f"Erreur serveur: {str(e)}"}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

def get_user_context(utilisateur):
    """Récupère les données de l'utilisateur pour personnaliser les réponses"""
    try:
        # Récupérer les compteurs de l'utilisateur
        compteurs = Compteur.objects.filter(utilisateur=utilisateur)
        prises = Prise.objects.filter(compteur__in=compteurs)
        
        # Données de consommation récentes (7 derniers jours)
        date_limite = timezone.now() - timedelta(days=7)
        mesures_recentes = Mesure.objects.filter(
            compteur__in=compteurs,
            timestamp__gte=date_limite
        )
        
        # Alertes récentes
        alertes_recentes = Alert.objects.filter(
            prise__in=prises,
            date__gte=date_limite
        )
        
        # Calculs de base
        conso_moyenne = mesures_recentes.aggregate(
            puissance_moy=Avg('puissance')
        )['puissance_moy'] or 0
        
        total_alertes = alertes_recentes.count()
        alertes_surconso = alertes_recentes.filter(type='SURCONSO').count()
        alertes_coupure = alertes_recentes.filter(type='COUPURE').count()
        
        context = {
            'nom_utilisateur': f"{utilisateur.prenom} {utilisateur.nom}",
            'nb_compteurs': compteurs.count(),
            'nb_prises': prises.count(),
            'consommation_moyenne': round(conso_moyenne, 2),
            'total_alertes': total_alertes,
            'alertes_surconsommation': alertes_surconso,
            'alertes_coupure': alertes_coupure,
            'periode_analyse': '7 derniers jours'
        }
        
        return context
        
    except Exception as e:
        return {
            'nom_utilisateur': f"{utilisateur.prenom} {utilisateur.nom}",
            'erreur_contexte': str(e)
        }

def generate_bot_response(user_message, context):
    """Génère une réponse avec l'API Gemini"""
    try:
        # Modèle Gemini à utiliser
        model = genai.GenerativeModel('gemini-2.0-flash')
        
        # Prompt système pour guider l'IA
        system_prompt = f"""
Tu es un assistant intelligent spécialisé dans la gestion énergétique et les compteurs électriques.
Tu aides les utilisateurs à comprendre leur consommation électrique et à optimiser leur usage.

Contexte de l'utilisateur {context['nom_utilisateur']}:
- Nombre de compteurs: {context.get('nb_compteurs', 0)}
- Nombre de prises: {context.get('nb_prises', 0)}
- Consommation moyenne: {context.get('consommation_moyenne', 0)}W
- Alertes récentes: {context.get('total_alertes', 0)} (dont {context.get('alertes_surconsommation', 0)} surconsommations et {context.get('alertes_coupure', 0)} coupures)
- Période d'analyse: {context.get('periode_analyse', 'N/A')}

Règles de réponse:
1. Réponds en français
2. Sois concis et pratique
3. Donne des conseils personnalisés basés sur les données
4. Si l'utilisateur pose une question générale, utilise son contexte pour personnaliser
5. Pour les questions techniques, explique clairement
6. Propose des solutions concrètes pour économiser l'énergie
7. Limite tes réponses à 200 mots maximum

Message de l'utilisateur: {user_message}
"""
        
        # Génération de la réponse
        response = model.generate_content(system_prompt)
        
        return response.text
        
    except Exception as e:
        # Réponse de fallback en cas d'erreur
        return f"Désolé, je rencontre un problème technique. Pouvez-vous reformuler votre question ? Erreur: {str(e)}"

@api_view(['GET'])
def get_chat_history(request):
    """Récupère l'historique des conversations d'un utilisateur"""
    try:
        utilisateur_id = request.query_params.get('utilisateur_id')
        limit = int(request.query_params.get('limit', 50))
        
        if not utilisateur_id:
            return Response(
                {"error": "utilisateur_id requis"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        messages = ChatMessage.objects.filter(
            utilisateur_id=utilisateur_id
        ).order_by('-timestamp')[:limit]
        
        serializer = ChatMessageSerializer(messages, many=True)
        
        return Response({
            "messages": serializer.data,
            "count": messages.count()
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response(
            {"error": str(e)}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

@api_view(['DELETE'])
def clear_chat_history(request):
    """Efface l'historique des conversations d'un utilisateur"""
    try:
        utilisateur_id = request.data.get('utilisateur_id')
        
        if not utilisateur_id:
            return Response(
                {"error": "utilisateur_id requis"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        deleted_count = ChatMessage.objects.filter(
            utilisateur_id=utilisateur_id
        ).delete()[0]
        
        return Response({
            "message": f"{deleted_count} messages supprimés",
            "deleted_count": deleted_count
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response(
            {"error": str(e)}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


# Ajoutez ces vues dans votre views.py pour gérer la connexion

@api_view(['POST'])
def login_user(request):
    """Connexion utilisateur simple"""
    try:
        email = request.data.get('email')
        mot_de_passe = request.data.get('mot_de_passe')
        
        if not email or not mot_de_passe:
            return Response(
                {"error": "Email et mot de passe requis"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Recherche de l'utilisateur
        utilisateur = Utilisateur.objects.get(
            email=email, 
            mot_de_passe=mot_de_passe  # En production, utilisez un hash !
        )
        
        serializer = UtilisateurSerializer(utilisateur)
        
        return Response({
            "message": "Connexion réussie",
            "utilisateur": serializer.data
        }, status=status.HTTP_200_OK)
        
    except Utilisateur.DoesNotExist:
        return Response(
            {"error": "Email ou mot de passe incorrect"}, 
            status=status.HTTP_401_UNAUTHORIZED
        )
    except Exception as e:
        return Response(
            {"error": str(e)}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

@api_view(['GET'])
def get_user_by_email(request):
    """Récupère un utilisateur par email"""
    try:
        email = request.query_params.get('email')
        
        if not email:
            return Response(
                {"error": "Email requis"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        utilisateur = Utilisateur.objects.get(email=email)
        serializer = UtilisateurSerializer(utilisateur)
        
        return Response(serializer.data, status=status.HTTP_200_OK)
        
    except Utilisateur.DoesNotExist:
        return Response(
            {"error": "Utilisateur non trouvé"}, 
            status=status.HTTP_404_NOT_FOUND
        )
    except Exception as e:
        return Response(
            {"error": str(e)}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )