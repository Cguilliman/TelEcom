from rest_framework.generics import (CreateAPIView, ListAPIView,
                                     RetrieveAPIView, UpdateAPIView)
from rest_framework.permissions import IsAuthenticated

from ..models import Catalog
from .serializers import CatalogSerializer


class PersonCatalogViewMixin:
    permission_classes = (IsAuthenticated,)

    def get_queryset(self):
        return Catalog.objects.filter(owner=self.request.user)


class CatalogListAPIView(PersonCatalogViewMixin, ListAPIView):
    serializer_class = CatalogSerializer


class CatalogReceiveAPIView(PersonCatalogViewMixin, RetrieveAPIView):
    serializer_class = CatalogSerializer


class CatalogCreateAPIView(PersonCatalogViewMixin, CreateAPIView):
    serializer_class = CatalogSerializer


class CatalogUpdateAPIView(PersonCatalogViewMixin, UpdateAPIView):
    serializer_class = CatalogSerializer
