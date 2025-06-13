from rest_framework import viewsets, status
from rest_framework.response  import Response
from rest_framework.decorators import api_view
from django.utils import timezone
from .models import Utilisateur, Compteur, Mesure , Prise, Alert, HistoriqueConsommation
from .serializers import UtilisateurSerializer, CompteurSerializer, MesureSerializer, PriseSerializer, AlertSerializer, HistoriqueConsommationSerializer

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
