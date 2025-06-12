from rest_framework import serializers
from .models import Utilisateur, Compteur, Mesure, Alert , Prise, HistoriqueConsommation 

class UtilisateurSerializer(serializers.ModelSerializer):
    class Meta:
        model = Utilisateur
        fields = '__all__'

class CompteurSerializer(serializers.ModelSerializer):
    class Meta:
        model = Compteur
        fields = '__all__'

class MesureSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mesure
        fields = '__all__'

class AlertSerializer(serializers.ModelSerializer):
    class Meta:
        model = Alert
        fields = '__all__'


class PriseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Prise
        fields = '__all__'

class HistoriqueConsommationSerializer(serializers.ModelSerializer):
    class Meta:
        model = HistoriqueConsommation
        fields = '__all__'