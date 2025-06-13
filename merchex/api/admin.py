from django.contrib import admin
from .models import Utilisateur, Compteur, Mesure,Prise

# Register your models here.
admin.site.register(Utilisateur)
admin.site.register(Compteur)
admin.site.register(Mesure)
admin.site.register(Prise)
