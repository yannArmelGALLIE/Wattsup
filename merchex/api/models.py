from django.db import models

# Create your models here.

###User 
class Utilisateur(models.Model):
    identifiant = models.BigAutoField(primary_key = True) #id_user
    nom = models.CharField(max_length = 30) #last_name
    prenom = models.CharField(max_length = 30) #first_name
    email = models.CharField(max_length = 30) #e-mail
    numero_tel = models.IntegerField() #phone
    mot_de_passe = models.CharField(max_length = 20) #password

    def __str__(self):
        return f"{self.nom} {self.prenom}"

###Electric meter
class Compteur(models.Model):
    identifiant_compteur = models.BigIntegerField(primary_key = True) #meter_identifier
    numero_compteur = models.BigIntegerField() #meter_number
    exploitation = models.CharField(max_length = 50) #municipality
    reference = models.BigIntegerField() #reference
    type_client = models.IntegerField() #nature of subscription
    utilisateur = models.ForeignKey(Utilisateur, on_delete = models.CASCADE) #user

    def __str__(self):
        return f"Compteur {self.numero_compteur} de {self.utilisateur.nom}"

###Measure
class Mesure(models.Model):
    tension = models.FloatField() #tension
    courant = models.FloatField() #fluent
    puissance = models.FloatField() #power
    timestamp = models.DateTimeField(auto_now_add=True)
    compteur = models.ForeignKey(Compteur, on_delete=models.CASCADE) #electric meter

    def __str__(self):
        return f"{self.compteur.numero} | {self.timestamp.strftime('%Y-%m-%d %H:%M')} : {self.puissance}W"

    



