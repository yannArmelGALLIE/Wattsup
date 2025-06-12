from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UtilisateurViewSet, CompteurViewSet, MesureViewSet, AlertViewSet, PriseViewSet, HistoriqueConsommationViewSet , recevoir_mesure

router = DefaultRouter()
router.register(r'utilisateurs', UtilisateurViewSet)
router.register(r'compteurs', CompteurViewSet)
router.register(r'mesures', MesureViewSet)
router.register(r'alerts', AlertViewSet)
router.register(r'prises', PriseViewSet)
router.register(r'historique-consommation', HistoriqueConsommationViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('esp32/recevoir_mesure/', recevoir_mesure),  # Endpoint for ESP32 to send measurements
]
