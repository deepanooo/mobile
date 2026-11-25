from django.contrib import admin
from django.urls import include, path
from rest_framework.authtoken.views import obtain_auth_token
from portfolio.views import logout_view

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/auth/login/", obtain_auth_token, name="api-login"),
    path("api/auth/logout/", logout_view, name="api-logout"),
    path("api/", include("portfolio.urls")),
]
