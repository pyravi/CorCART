from django.urls import path,include
from django.views.generic import  RedirectView
#RestAPi 
from rest_framework import routers
from . import api_views
from .views import(
    Homeview,
    search,
    product, 
    Cartview, 
    CheckoutView,
    add_to_cart,
    remove_from_cart,
    remove_single_item_from_cart, 
    shop,
    OrderSuccessfully,
    PaymentView,
    RequestRefundView,
    AddCouponView,
    SearchView,
    ContactView,
    Termview,
    PolicyView,
    test
) 
from .chatbot.chatintapi import chat
app_name = 'public'

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.

router = routers.DefaultRouter()
router.register(r'Item', api_views.ItemViewSet)
router.register(r'Category',api_views.CategoryViewSet)
router.register(r'OrderItem',api_views.OrderItemViewSet)
router.register(r'Order',api_views.OrderViewSet)
router.register(r'Payment',api_views.PaymentViewSet)
router.register(r'Refund',api_views.RefundViewSet)

urlpatterns = [
    path('', Homeview.as_view(), name='index'),
 #   path('search/',search,name='search'),
    #path('favicon\.ico', RedirectView.as_view(url='/static/images/favicon.ico')),
    path('test/', test, name='test'),
    path('product/<slug>/', product, name='product'),
    path('add-to-cart/<slug>/', add_to_cart, name='add-to-cart'),
    path('cart/', Cartview.as_view(), name='cart'),
    path('checkout/', CheckoutView.as_view(), name='checkout'),
    path('add-coupon/', AddCouponView.as_view(), name='add-coupon'),
    path('remove-from-cart/<slug>/', remove_from_cart, name='remove-from-cart'),
    path('remove-item-from-cart/<slug>/', remove_single_item_from_cart, name='remove-single-item-from-cart'),
    path('shop/', shop.as_view(), name='shop'),
    path("OrderSuccessfully/",OrderSuccessfully,name="OrderSuccessfully"),
    path("payment/<payment_option>/",PaymentView.as_view(),name="payment"),
    path("request-refund/",RequestRefundView.as_view(),name="request-refund"),
    path("chat/",chat,name='chat'),
    path('api/', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('search/',SearchView.as_view(),name='search'),
    path("terms/",Termview.as_view(),name="terms"),
    path("policy/",PolicyView.as_view(),name="policy"),
    path("contact/",ContactView.as_view(),name="contact"),
    ]
