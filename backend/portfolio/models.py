from django.conf import settings
from django.db import models

class Project(models.Model):
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="projects")
    name = models.CharField(max_length=160)
    description = models.TextField()
    category = models.CharField(max_length=80)
    technologies = models.CharField(max_length=255, blank=True)
    project_link = models.URLField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return self.name

class Profile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name="profile")
    full_name = models.CharField(max_length=160, blank=True)
    bio = models.TextField(blank=True)
    avatar_url = models.URLField(blank=True)

    def __str__(self):
        return self.full_name or self.user.username
