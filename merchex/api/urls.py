from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UtilisateurViewSet, CompteurViewSet, MesureViewSet

router = DefaultRouter()
router.register(r'utilisateurs', UtilisateurViewSet)
router.register(r'compteurs', CompteurViewSet)
router.register(r'mesures', MesureViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
