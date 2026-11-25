from rest_framework.routers import DefaultRouter
from django.urls import include, path
from .views import ProjectViewSet, RegisterView, profile_view

router = DefaultRouter()
router.register("projects", ProjectViewSet, basename="project")

urlpatterns = [
    path("auth/register/", RegisterView.as_view(), name="api-register"),
    path("profile/", profile_view, name="api-profile"),
    path("", include(router.urls)),
]
