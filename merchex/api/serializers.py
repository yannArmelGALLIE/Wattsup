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



# Ajoutez ce serializer à votre serializers.py
from .models import ChatMessage

class ChatMessageSerializer(serializers.ModelSerializer):
    utilisateur_nom = serializers.CharField(source='utilisateur.nom', read_only=True)
    utilisateur_prenom = serializers.CharField(source='utilisateur.prenom', read_only=True)
    
    class Meta:
        model = ChatMessage
        fields = [
            'id', 
            'utilisateur', 
            'utilisateur_nom', 
            'utilisateur_prenom',
            'message', 
            'sender', 
            'timestamp'
        ]
        read_only_fields = ['id', 'timestamp']