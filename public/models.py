from django.db import models
from django.shortcuts import reverse
from django_countries.fields import CountryField
# from cities.models import BaseCountry
from phone_field import PhoneField
from django.db.models.signals import post_save
from django.utils.timezone import datetime
from django.conf import settings
from mptt.models import MPTTModel, TreeForeignKey
import math
# Create your models here.

from django.db.models import Q
class PostManager(models.Manager):
    def search(self, query=None):
        qs = self.get_queryset()
        if query is not None:
           or_lookup = (Q(product_title__icontains=query) | Q(product_description__icontains=query)| Q(product_slug__icontains=query))
           qs = qs.filter(or_lookup).distinct() # distinct() is often necessary with Q lookups
        return qs



class Retailer(models.Model):
    retailer_id = models.AutoField(primary_key=True)
    retailer_firstname =models.CharField(max_length=35)
    retailer_lastname =models.CharField(max_length=25)
    retailer_GSTIN =models.CharField(max_length=25)
    retailer_phonenumber=PhoneField(help_text = 'Contact mobile number')
    retailer_phonenumber2=PhoneField(null=True,blank=True)
    retailer_register_email_id=models.EmailField()
    retailer_email_id=models.EmailField(null=True,blank=True)
    longtitue=models.FloatField()
    antitude=models.FloatField()
    complete_address=models.CharField(max_length=100)

    def __str__(self):
        return self.retailer_firstname
    


class UserProfile(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    stripe_customer_id = models.CharField(max_length=50, blank=True, null=True)
    one_click_purchasing = models.BooleanField(default=False)

    def __str__(self):
        return self.user.username


class Slider(models.Model):
    silder_id = models.AutoField(primary_key=True)
    slider_image = models.ImageField(upload_to='picture')
    slider_title = models.CharField(max_length=100)
    slider_description = models.TextField()

    def __str__(self):
        return f'{self.slider_title} is {self.silder_id} '


# MPTT is a technique for storing hierarchical data in a database. The aim is to make retrieval operations very efficient.

class Category(MPTTModel):
    name = models.CharField(max_length=200, unique=True)
    slug = models.SlugField()
    parent = TreeForeignKey('self', blank=True, null=True, related_name='children', on_delete=models.CASCADE)

    class MPTTMeta:
        unique_together = ('slug', 'parent', 'name')
        verbose_name_plural = "categories"

    def __str__(self):
        full_path = [ self.name ]
        k = self.parent
        while k is not None:
            full_path.append(k.name)
            k = k.parent
        return ' -> '.join(full_path[ ::-1 ])


class Item(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_category = TreeForeignKey('Category', blank=True, null=True, on_delete=models.CASCADE)
    product_title = models.CharField(max_length=100)
    product_slug = models.SlugField()
    product_description = models.TextField()
    product_image = models.ImageField(upload_to='product')
    product_price = models.FloatField()
    product_offer = models.BooleanField(default=False)
    product_discount_price = models.FloatField(blank=True, null=True)
    stock = models.PositiveIntegerField(blank=True)
    objects=PostManager()

    def __str__(self):
        return f'{self.product_id} of {self.product_title}'

    def get_absolute_url(self):
        return reverse("public:product", kwargs={
            'slug': self.product_slug
        })

    def get_add_to_cart_url(self):
        return reverse("public:add-to-cart", kwargs={
            'slug': self.product_slug
        })

    def get_remove_from_cart_url(self):
        return reverse("public:remove-from-cart", kwargs={
            'slug': self.product_slug
        })

    def discount_percentage(self):
        return math.ceil(100 - self.product_discount_price / self.product_price * 100)
		

    def image_tag(self):
        from django.utils.html import format_html
        return format_html('<img src= "/media/{}" width="30" height="30" />'.format(self.product_image))
    image_tag.allow_tags = True
    image_tag.short_description='Image'
    
class Image(models.Model):
    product = models.ForeignKey(Item, default=None, related_name='images',on_delete=models.CASCADE)
    image = models.ImageField(upload_to='products/%Y/%m/%d', blank=True)
    
    def __str__(self):
        return self.product.product_title



class OrderItem(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             on_delete=models.CASCADE)
    ordered = models.BooleanField(default=False)
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1)

    def __str__(self):
        return f"{self.item.product_title} No. of quantity : {self.quantity}"

    def get_total_item_price(self):
        return self.quantity * self.item.product_price

    def get_total_discount_item_price(self):
        return self.quantity * self.item.product_discount_price

    def get_amount_saved(self):
        return self.get_total_item_price() - self.get_total_discount_item_price()

    def get_final_price(self):
        if self.item.product_discount_price:
            return self.get_total_discount_item_price()
        return self.get_total_item_price()


class Order(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             on_delete=models.CASCADE)
    ref_code = models.CharField(max_length=20, blank=True, null=True)
    items = models.ManyToManyField(OrderItem)
    start_date = models.DateTimeField(auto_now_add=True)
    ordered_date = models.DateTimeField()
    ordered = models.BooleanField(default=False)
    shipping_address = models.ForeignKey(
        'Address', related_name='sstreetaddress', on_delete=models.SET_NULL, blank=True, null=True)
    billing_address = models.ForeignKey(
        'Address', related_name='dstreetaddress', on_delete=models.SET_NULL, blank=True, null=True)
    payment = models.ForeignKey(
        'Payment', on_delete=models.SET_NULL, blank=True, null=True)
    coupon = models.ForeignKey(
        'Coupon', on_delete=models.SET_NULL, blank=True, null=True)
    being_delivered = models.BooleanField(default=False)
    received = models.BooleanField(default=False)
    refund_requested = models.BooleanField(default=False)
    refund_granted = models.BooleanField(default=False)

    '''
    1. Item added to cart
    2. Adding a billing address
    (Failed checkout)
    3. Payment
    (Preprocessing, processing, packaging etc.)
    4. Being delivered
    5. Received
    6. Refunds
    '''

    def __str__(self):
        return self.user.username
    
    def get_order_total(self):
        total = 0
        for order_item in self.items.all():
            total += order_item.get_final_price()
        return total

    def get_total(self):
        total = 0
        for order_item in self.items.all():
            total += order_item.get_final_price()
        if self.coupon:
            total -= self.coupon.amount
        return total


ADDRESS_CHOICES = (
    ('B', 'Billing'),
    ('S', 'Shipping'),
)


class Address(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             on_delete = models.CASCADE)
    firstname = models.CharField(max_length = 25)
    lastname = models.CharField(max_length = 20, blank= True)
    email = models.EmailField()
    phone = PhoneField(help_text = 'Contact mobile number') 
    street_address = models.CharField(max_length = 100)
    apartment_address = models.CharField(max_length = 100, blank = True)
    city = models.CharField(max_length = 35)
    #ciity = BaseCountry(multiple=False)
    country = CountryField(multiple=False)
    zipcode = models.CharField(max_length =15)
    address_type = models.CharField(max_length = 1, choices = ADDRESS_CHOICES)
    default = models.BooleanField(default = False)

    def __str__(self):
        return self.user.username

    class Meta:
        verbose_name_plural = 'Addresses'


class Payment(models.Model):
    stripe_charge_id = models.CharField(max_length=50)
    user = models.ForeignKey(settings.AUTH_USER_MODEL,
                             on_delete=models.SET_NULL, blank=True, null=True)
    amount = models.FloatField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.user.username


class Coupon(models.Model):
    code = models.CharField(max_length=15)
    amount = models.FloatField()

    def __str__(self):
        return self.code


class Refund(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    reason = models.TextField()
    accepted = models.BooleanField(default=False)
    email = models.EmailField()

    def __str__(self):
        return f"{self.pk}"


def userprofile_receiver(sender, instance, created, *args, **kwargs):
    if created:
        userprofile = UserProfile.objects.create(user=instance)


post_save.connect(userprofile_receiver, sender=settings.AUTH_USER_MODEL)
