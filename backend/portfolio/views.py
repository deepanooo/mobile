from django.contrib.auth import get_user_model
from rest_framework import generics, permissions, status, viewsets
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from .models import Profile, Project
from .serializers import ProfileSerializer, ProjectSerializer, RegistrationSerializer

User = get_user_model()

class ProjectViewSet(viewsets.ModelViewSet):
    serializer_class = ProjectSerializer

    def get_queryset(self):
        # Portfolio projects are publicly readable; writes remain authenticated.
        return Project.objects.all()

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

    def get_permissions(self):
        if self.action in ("list", "retrieve"):
            return [permissions.AllowAny()]
        return [permissions.IsAuthenticated()]

class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = RegistrationSerializer
    permission_classes = [permissions.AllowAny]

@api_view(["GET", "PATCH", "PUT"])
@permission_classes([permissions.IsAuthenticated])
def profile_view(request):
    profile, _ = Profile.objects.get_or_create(user=request.user)
    if request.method == "GET":
        return Response(ProfileSerializer(profile).data)
    serializer = ProfileSerializer(profile, data=request.data, partial=request.method == "PATCH")
    serializer.is_valid(raise_exception=True)
    serializer.save()
    return Response(serializer.data)

@api_view(["POST"])
@permission_classes([permissions.IsAuthenticated])
def logout_view(request):
    request.auth.delete()
    return Response(status=status.HTTP_204_NO_CONTENT)
