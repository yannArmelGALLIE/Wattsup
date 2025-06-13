from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UtilisateurViewSet, CompteurViewSet, MesureViewSet, AlertViewSet, PriseViewSet, HistoriqueConsommationViewSet , recevoir_mesure, chat_with_bot, get_chat_history, clear_chat_history , ChatMessageViewSet, login_user, get_user_by_email

router = DefaultRouter()
router.register(r'utilisateurs', UtilisateurViewSet)
router.register(r'compteurs', CompteurViewSet)
router.register(r'mesures', MesureViewSet)
router.register(r'alerts', AlertViewSet)
router.register(r'prises', PriseViewSet)
router.register(r'historique-consommation', HistoriqueConsommationViewSet)
router.register(r'chat-messages', ChatMessageViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('api/chat/', chat_with_bot, name='chat_with_bot'),  # Nouveau
    path('api/chat/history/', get_chat_history, name='get_chat_history'),  # Nouveau
    path('api/chat/clear/', clear_chat_history, name='clear_chat_history'),
    path('api/login/', login_user, name='login_user'),
    path('api/user/', get_user_by_email, name='get_user_by_email'),  # Nouveau
    path('api/esp32/recevoir_mesure/', recevoir_mesure, name='recevoir_mesure'), # Endpoint for ESP32 to send measurements
]
