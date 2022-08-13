from django.urls import include, path

from . import views


urlpatterns = [
    path(
        "catalog/",
        include(
            (
                (
                    path("list/", views.CatalogListAPIView.as_view(), name="list"),
                    path("create/", views.CatalogCreateAPIView.as_view(), name="create"),
                    path(
                        "<int:pk>/update/",
                        views.CatalogUpdateAPIView.as_view(),
                        name="update",
                    ),
                    path(
                        "<int:pk>/receive/",
                        views.CatalogReceiveAPIView.as_view(),
                        name="receive",
                    ),
                ),
                "catalog",
            )
        ),
    ),
]
