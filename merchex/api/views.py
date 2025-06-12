from rest_framework import viewsets, status
from rest_framework.responce  import Response
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

    def create(self, request, *args, **kwargs):
        data = request.data
        data['timestamp'] = timezone.now()
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        mesure = serializer.save()
        self.update_historique(mesure)
        

        puissance = mesure.puissance
        tension = mesure.tension
        courant = mesure.courant
        if puissance > 2500:
            alert = Alert.objects.create(
                prise=mesure.compteur.prise_set.first(),  # Assuming each compteur has a related prise
                type='SURCONSO',
                message=f'Surconsommation détectée : {puissance}W',
                date=timezone.now()
            )
            alert.save()

        elif puissance <= 1 or puissance >= 0.01:
            alert = Alert.objects.create(
                prise=mesure.compteur.prise_set.first(),  # Assuming each compteur has a related prise
                type='COUPURE',
                message=f'Coupure de courant détectée : {tension}V',
                date=timezone.now()
            )
            alert.save()



    def update_historique(self, mesure):
        jour = timezone.now().date()
        historique, created = HistoriqueConsommation.objects.get_or_create(
            compteur=mesure.compteur,
            date=jour,
            defaults={'consommation': 0}
        )
        historique.consommation += mesure.puissance
        historique.save()


class PriseViewSet(viewsets.ModelViewSet):
    queryset = Prise.objects.all()
    serializer_class = PriseSerializer

class AlertViewSet(viewsets.ModelViewSet):
    queryset = Alert.objects.all()
    serializer_class = AlertSerializer

class HistoriqueConsommationViewSet(viewsets.ModelViewSet):
    queryset = HistoriqueConsommation.objects.all()
    serializer_class = HistoriqueConsommationSerializer


