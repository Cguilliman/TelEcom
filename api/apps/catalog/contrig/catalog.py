from django.conf import settings
from rest_framework.serializers import ModelSerializer

from kafka.producer import KafkaProducer

from apps.catalog.models import Catalog


producer = KafkaProducer(**settings.KAFKA_CONFIGS)


class CatalogSerializer(ModelSerializer):

    class Meta:
        model = Catalog
        fields = "__all__"


def send_catalog_update(catalog: Catalog):
    entity = CatalogSerializer(catalog).data
    producer.send("catalog-update", entity)
