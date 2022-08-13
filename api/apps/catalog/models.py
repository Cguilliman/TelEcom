from django.conf import settings
from django.db import models
from django.utils.translation import gettext_lazy as _


class Catalog(models.Model):
    title = models.CharField(
        verbose_name=_("Title"),
        max_length=255,
    )
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, verbose_name=_("Owner"), on_delete=models.CASCADE)

    class Meta:
        verbose_name = _("Catalog")
        verbose_name_plural = _("Catalogs")

    def __str__(self):
        return self.title


class Attribute(models.Model):
    name = models.CharField(
        verbose_name=_("Name"),
        max_length=255,
    )
    catalog = models.ForeignKey("catalog.Catalog", verbose_name=_("Catalog"), on_delete=models.CASCADE)

    class Meta:
        verbose_name = _("Attribute")
        verbose_name_plural = _("Attributes")

    def __str__(self):
        return self.name


class Asset(models.Model):
    title = models.CharField(verbose_name=_("Title"), max_length=255)
    catalog = models.ForeignKey("catalog.Catalog", verbose_name=_("Catalog"), on_delete=models.CASCADE)

    class Meta:
        verbose_name = _("Asset")
        verbose_name_plural = _("Assets")

    def __str__(self):
        return self.title


class AttributeValue(models.Model):
    value = models.TextField(verbose_name=_("Value"))
    attribute = models.ForeignKey("catalog.Attribute", verbose_name=_("Attribute"), on_delete=models.CASCADE)
    asset = models.ForeignKey("catalog.Asset", verbose_name=_("Asset"), on_delete=models.CASCADE)

    class Meta:
        verbose_name = _("Attribute value")
        verbose_name_plural = _("Attribute values")

    def __str__(self):
        return f"{self.asset_id}-{self.attribute_id}"
