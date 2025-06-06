from django.contrib import admin
from .models import Utilisateur, Compteur, Mesure

# Register your models here.
admin.site.register(Utilisateur)
admin.site.register(Compteur)
admin.site.register(Mesure)
