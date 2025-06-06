from rest_framework import generics
from .models import Utilisateur, Compteur, Mesure
from .serializers import UtilisateurSerializer, CompteurSerializer, MesureSerializer

# User
class UtilisateurGetCreate(generics.ListCreateAPIView):
    queryset = Utilisateur.objects.all()
    serializer_class = UtilisateurSerializer

class UtilisateurUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Utilisateur.objects.all()
    serializer_class = UtilisateurSerializer

# Electric meter
class CompteurGetCreate(generics.ListCreateAPIView):
    queryset = Compteur.objects.all()
    serializer_class = CompteurSerializer

class CompteurUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Compteur.objects.all()
    serializer_class = CompteurSerializer

# Measure
class MesureGetCreate(generics.ListCreateAPIView):
    queryset = Mesure.objects.all()
    serializer_class = MesureSerializer

class MesureUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Mesure.objects.all()
    serializer_class = MesureSerializer
