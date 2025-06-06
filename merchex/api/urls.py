from django.urls import path
from .views import UtilisateurGetCreate, UtilisateurUpdateDelete, CompteurGetCreate, CompteurUpdateDelete, MesureGetCreate, MesureUpdateDelete

urlpatterns = [
    path('utilisateur/', UtilisateurGetCreate.as_view()),
    path('utilisateur/<int:pk>/', UtilisateurUpdateDelete.as_view()),
    path('compteur/', CompteurGetCreate.as_view()),
    path('compteur/<int:pk>/', CompteurUpdateDelete.as_view()),
    path('mesure/', MesureGetCreate.as_view()),
    path('mesure/<int:pk>/', MesureUpdateDelete.as_view())
]