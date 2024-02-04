from django.contrib import admin

from .models import Asset, Attribute, AttributeValue, Catalog


admin.site.register(Catalog)
admin.site.register(Attribute)
admin.site.register(AttributeValue)
admin.site.register(Asset)
