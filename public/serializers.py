from rest_framework import serializers
from .models import Item,Category,Address,Payment,Order,OrderItem,Coupon,Refund
class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = ('product_id', 'product_title', 'product_slug', 'product_description','product_image','product_price','product_offer','product_discount_price')


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields =('name','slug','parent')

class AddressSerializer(serializers.ModelSerializer):
   class Meta:
       model = Item
       fields = ('user','firstname','lastname','email','phone','street_address','apartment_address','country','zipcode','address_type','default')


class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields =('stripe_charge_id','user','amount','timestamp')

class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = ('user', 'ordered', 'item', 'quantity')


class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields =('user','ref_code','items','start_date','ordered_date','ordered','shipping_address','billing_address','payment','coupon','being_delivered','received','refund_requested','refund_granted')
 
class CouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = ('code','amount')

class RefundSerializer(serializers.ModelSerializer):
    class Meta:
        model = Refund
        fields = ('order','reason','accepted','email')
