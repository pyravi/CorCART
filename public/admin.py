from mptt.admin import DraggableMPTTAdmin,MPTTModelAdmin
from django.contrib import admin
# Register your models here.
from .models import Item,Slider, OrderItem, Order, Payment, Coupon, Refund, Address, UserProfile,Category,Retailer,Image
admin.site.site_header = 'VMARTS.IN'



def make_refund_accepted(modeladmin, request, queryset):
    queryset.update(refund_requested=False, refund_granted=True)


make_refund_accepted.short_description = 'Update orders to refund granted'


class OrderAdmin(admin.ModelAdmin):
    list_display = ['user',
                    'ordered',
                    'being_delivered',
                    'received',
                    'refund_requested',
                    'refund_granted',
                    'shipping_address',
                    'billing_address',
                    'payment',
                    'coupon',
                    'ordered_date'
                    ]
    list_display_links = [
        'user',
        'shipping_address',
        'billing_address',
        'payment',
        'coupon'
    ]
    list_filter = ['ordered',
                   'being_delivered',
                   'received',
                   'refund_requested',
                   'refund_granted']
    search_fields = [
        'user__username',
        'ref_code'
    ]
    actions = [make_refund_accepted]


class AddressAdmin(admin.ModelAdmin):
    list_display = [
        'user',
        'city',
        'zipcode',
        'country',
        'phone',
        'email',
        'address_type',
        'default'
    ]
    list_filter = ['default', 'address_type', 'city']
    search_fields = ['phone', 'zipcode']

class ProductImagesInline(admin.StackedInline):
    model = Image


class ItemAdmin(admin.ModelAdmin):
    list_display = [
        'product_id',
        'product_title',
        'image_tag',
        'product_description',
        'product_offer'
    ]
    #readonly_fields = ['image_tag']
    list_filter = ['product_title', 'product_offer']
    search_fields = ['product_title']
    inlines = [ProductImagesInline]

class PaymentAdmin(admin.ModelAdmin):
    list_display = [
                'user',
                'stripe_charge_id',
                'amount',
                'timestamp'
    ]
    #readonly_fields = ['image_tag']
    list_filter = ['user', 'timestamp']


class CategoryAdmin(DraggableMPTTAdmin,MPTTModelAdmin):
    mptt_indent_field = "Category of products"

    # list_display = ('tree_actions', 'indented_title',
    #                 'related_products_count', 'related_products_cumulative_count')
    # list_display_links = ('indented_title',)

    # def get_queryset(self, request):
    #     qs = super().get_queryset(request)

    #     # Add cumulative product count
    #     qs = Category.objects.add_related_count(
    #             qs,
    #             Item,
    #             'category_id',
    #             'products_cumulative_count',
    #             cumulative=True)

    #     # Add non cumulative product count
    #     qs = Category.objects.add_related_count(qs,
    #              Item,
    #              'categories',
    #              'products_count',
    #              cumulative=False)
    #     return qs

    # def related_products_count(self, instance):
    #     return instance.products_count
    # related_product_count.short_description = 'Related products (for this specific category)'

    # def related_products_cumulative_count(self, instance):
    #     return instance.products_cumulative_count
    # related_products_cumulative_count.short_description = 'Related products (in tree)'



admin.site.register(Retailer)
admin.site.register(Slider)
admin.site.register(Item,ItemAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(OrderItem)
admin.site.register(Order, OrderAdmin)
admin.site.register(Payment,PaymentAdmin)
admin.site.register(Coupon)
admin.site.register(Refund)
admin.site.register(Address, AddressAdmin)
admin.site.register(UserProfile)
