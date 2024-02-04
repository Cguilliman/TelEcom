from rest_framework import serializers

from apps.catalog.contrig.catalog import send_catalog_update
from ..models import Asset, Attribute, AttributeValue, Catalog


class CatalogSerializer(serializers.ModelSerializer):
    class Meta:
        model = Catalog
        fields = ("id", "title")

    def create(self, validated_data):
        validated_data["owner"] = self.context.get("request").user
        catalog = super().create(validated_data)
        send_catalog_update(catalog)
        return catalog
