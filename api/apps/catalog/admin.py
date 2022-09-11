from django.contrib import admin

from .models import Catalog, Attribute, AttributeValue, Asset


admin.site.register(Catalog)
admin.site.register(Attribute)
admin.site.register(AttributeValue)
admin.site.register(Asset)
