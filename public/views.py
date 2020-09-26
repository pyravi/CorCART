from django.conf import settings
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.core.exceptions import ObjectDoesNotExist
from django.utils import timezone
from django.views.generic import ListView, DetailView, View
from django.views.generic.base import TemplateView
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import Item, Slider, Order, OrderItem, Address, Category, Payment, Coupon, UserProfile ,Refund
from .forms import CheckoutForm, CouponForm, RefundForm, PaymentForm
from django.http import HttpResponse
from django.views.decorators.http import require_http_methods
import random
import string
import stripe
import json
from .search import SearchView

stripe.api_key = settings.STRIPE_SECRET_KEY

class Termview(TemplateView):
    template_name='terms-conditions.html'

class PolicyView(TemplateView):
    template_name='privacy-policy.html'

class ContactView(TemplateView):
    template_name='contact.html'


def create_ref_code():
    return ''.join(random.choices(string.ascii_lowercase + string.digits, k=20))

# Create your views here.


class Homeview(TemplateView):
    template_name = "index.html"
    def get_context_data(self, **kwargs):
        context = super(Homeview, self).get_context_data(**kwargs)
        context['items'] = Item.objects.all()
        context['slider'] = Slider.objects.all()
        context['category'] = Category.objects.all()
        return context
    # def search(self):
    #     data=self.request.GET["myInput"]
    #     print(data)
    # class paginate(ListView):
    #     paginate_by = 4


def searchMatch(query, item):
    '''return true only if query matches the item'''
    if query in item.product_description.lower() or query in item.product_title.lower() or query in item.product_category.name.lower():
        return True
    else:
        return False


def search(request):
    query = request.GET.get('search')
    #print(query)
    allProds = []
    catprods = Item.objects.values('product_category_id', 'product_id')
    cats = {item['product_category_id'] for item in catprods}
    for cat in cats:
        prodtemp = Item.objects.filter(product_category_id=cat)
        prod = [item for item in prodtemp if searchMatch(query, item)]
        #n = len(prod)
        #nSlides = n // 4 + ceil((n / 4) - (n // 4))
        if len(prod) != 0:
            allProds.append(prod)
            #allProds.append([prod, range(1, nSlides), nSlides])
    params = {'items_list': allProds, "msg": "",'slider':Slider.objects.all(),'category':Category.objects.all()}
    #print(params)
    if len(allProds) == 0 or len(query) < 4:
        params = {'msg': "Please make sure to enter relevant search query",'slider':Slider.objects.all(),'category':Category.objects.all()}
    return render(request, 'search.html', params)


# @require_http_methods(["GET", "POST"])
#@csrf_exempt
def test(request):
    return render(request,'test.html')

def showcategory(request, hierarchy=None):
    pass


def product(request, slug):
    content = {
        'items': Item.objects.filter(product_slug=slug)
    }
    return render(request, 'product.html', content)


@login_required
def add_to_cart(request, slug):
    item = get_object_or_404(Item, product_slug=slug)
    order_item, created = OrderItem.objects.get_or_create(
        item=item,
        user=request.user,
        ordered=False
    )
    order_qs = Order.objects.filter(user=request.user, ordered=False)
    if order_qs.exists():
        order = order_qs[ 0 ]
        # check if the order item is in the order
        if order.items.filter(item__product_slug=item.product_slug).exists():
            order_item.quantity += 1
            order_item.save()
            messages.info(request, "This item quantity was updated.")
            return redirect("/")
        else:
            order.items.add(order_item)
            messages.info(request, "This item was added to your cart.")
            return redirect("/")
    else:
        ordered_date = timezone.now()
        order = Order.objects.create(
            user=request.user, ordered_date=ordered_date)
        order.items.add(order_item)
        messages.info(request, "This item was added to your cart.")
        return redirect("public:cart")


@login_required
def remove_from_cart(request, slug):
    item = get_object_or_404(Item, product_slug=slug)
    order_qs = Order.objects.filter(
        user=request.user,
        ordered=False
    )
    if order_qs.exists():
        order = order_qs[ 0 ]
        # check if the order item is in the order
        if order.items.filter(item__product_slug=item.product_slug).exists():
            order_item = OrderItem.objects.filter(
                item=item,
                user=request.user,
                ordered=False
            )[ 0 ]
            order.items.remove(order_item)
            messages.info(request, "This item was removed from your cart.")
            return redirect("public:cart")
        else:
            messages.info(request, "This item was not in your cart")
            return redirect("public:cart", product_slug=slug)
    else:
        messages.info(request, "You do not have an active order")
        return redirect("public:cart", product_slug=slug)


class shop(ListView):
    model = Item
    paginate_by = 4
    template_name = "shop.html"

def get_coupon(request, code):
    try:
        coupon = Coupon.objects.get(code=code)
        return coupon
    except ObjectDoesNotExist:
        messages.info(request, "This coupon does not exist")
        return redirect("public:checkout")


class AddCouponView(View):
    def post(self, *args, **kwargs):
        form = CouponForm(self.request.POST or None)
        if form.is_valid():
            try:
                code = form.cleaned_data.get('code')
                order = Order.objects.get(
                    user=self.request.user, ordered=False)
                order.coupon = get_coupon(self.request, code)
                order.save()
                messages.success(self.request, "Successfully added coupon")
                return redirect("public:cart")
            except ObjectDoesNotExist:
                messages.info(self.request, "You do not have an active order")
                return redirect("public:cart")



class Cartview(LoginRequiredMixin, View):
    def get(self, *args, **kwargs):
        try:
            order = Order.objects.get(user=self.request.user, ordered=False)
            context = {
                'object': order,
                'couponform': CouponForm(),
                'DISPLAY_COUPON_FORM': True,
            }
            return render(self.request, 'cart.html', context)
        except ObjectDoesNotExist:
            messages.warning(self.request, "You do not have an active order")
            return redirect("/")


@login_required
def remove_single_item_from_cart(request, slug):
    item = get_object_or_404(Item, product_slug=slug)
    order_qs = Order.objects.filter(
        user=request.user,
        ordered=False
    )
    if order_qs.exists():
        order = order_qs[ 0 ]
        # check if the order item is in the order
        if order.items.filter(item__product_slug=item.product_slug).exists():
            order_item = OrderItem.objects.filter(
                item=item,
                user=request.user,
                ordered=False
            )[ 0 ]
            if order_item.quantity > 1:
                order_item.quantity -= 1
                order_item.save()
            else:
                order.items.remove(order_item)
            messages.info(request, "This item quantity was updated.")
            return redirect("public:cart")
        else:
            messages.info(request, "This item was not in your cart")
            return redirect("public:product", product_slug=slug)
    else:
        messages.info(request, "You do not have an active order")
        return redirect("public:product", product_slug=slug)


def is_valid_form(values):
    valid = True
    for field in values:
        if field == '':
            valid = False
    return valid



class CheckoutView(View):
    def get(self, *args, **kwargs):
        try:
            order = Order.objects.get(user=self.request.user, ordered=False)
            form = CheckoutForm()
            context = {
                'form': form,
                'couponform': CouponForm(),
                'order': order,
                'DISPLAY_COUPON_FORM': True
            }

            shipping_address_qs = Address.objects.filter(
                user=self.request.user,
                address_type='S',
                default=True
            )
            if shipping_address_qs.exists():
                context.update(
                    {'default_shipping_address': shipping_address_qs[0]})

            billing_address_qs = Address.objects.filter(
                user=self.request.user,
                address_type='B',
                default=True
            )
            if billing_address_qs.exists():
                context.update(
                    {'default_billing_address': billing_address_qs[ 0 ]})
            return render(self.request, "checkout.html", context)
        except ObjectDoesNotExist:
            messages.info(self.request, "You do not have an active order")
            return redirect("public:checkout")

    def post(self, *args, **kwargs):
        form = CheckoutForm(self.request.POST or None)
        #print(self.request.POST)
        try:
            order = Order.objects.get(user=self.request.user, ordered=False)
            if form.is_valid(): 
                use_default_shipping = form.cleaned_data.get('use_default_shipping')
                if use_default_shipping:
                    print("Using the default shipping address")
                    address_qs = Address.objects.filter(
                        user=self.request.user,
                        address_type='S',
                        default=True
                    )
                    if address_qs.exists():
                        shipping_address = address_qs[ 0 ]
                        order.shipping_address = shipping_address
                        order.save()
                    else:
                        messages.info(self.request, "No default shipping address available")
                        return redirect('public:checkout')
                else:
                    print("User is entering a new shipping address")
                    first_name = form.cleaned_data.get('sfirstname')
                    last_name = form.cleaned_data.get('slastname')
                    city = form.cleaned_data.get('scity')
                    apartment = form.cleaned_data.get('sapartment')
                    streetaddress = form.cleaned_data.get('sstreetaddress')
                    zipcode = form.cleaned_data.get('szipcode')
                    country = form.cleaned_data.get('shipping_country')
                    phone = form.cleaned_data.get('sphone')
                    email = form.cleaned_data.get('semail')
                    #print(first_name, last_name, city, streetaddress, zipcode, country , phone, email)
                    if is_valid_form([ first_name, email, phone, streetaddress, city, country, zipcode]):
                    #if is_valid_form([ city, zipcode, country  ]):
                        shipping_address = Address(
                            user = self.request.user,
                            firstname=first_name,
                            lastname=last_name,
                            country=country,
                            city=city,
                            apartment_address = apartment,
                            street_address=streetaddress,
                            zipcode = zipcode,
                            phone = phone,
                            email = email,
                            address_type='S'
                        )
                        shipping_address.save()
                        order.shipping_address = shipping_address
                        order.save()

                        set_default_shipping = form.cleaned_data.get('set_default_shipping')
                        if set_default_shipping:
                            shipping_address.default = True
                            shipping_address.save()
                    else:
                        messages.info(self.request, "Please fill in the required shipping address fields")
                
                use_default_billing = form.cleaned_data.get('use_default_billing')
                same_billing_address = form.cleaned_data.get('same_billing_address')

                if same_billing_address:
                    billing_address = shipping_address
                    billing_address.pk = None
                    billing_address.save()
                    billing_address.address_type = 'B'
                    billing_address.save()
                    order.billing_address = billing_address
                    order.save()

                elif use_default_billing:
                    print("Using the defualt billing address")
                    address_qs = Address.objects.filter(
                        user=self.request.user,
                        address_type='B',
                        default=True
                    )
                    if address_qs.exists():
                        billing_address = address_qs[ 0 ]
                        order.billing_address = billing_address
                        order.save()
                    else:
                        messages.info(
                            self.request, "No default billing address available")
                        return redirect('public:checkout')
                else:
                    print("User is entering a new billing address")
                    first_name= form.cleaned_data.get('dfirstname')
                    last_name= form.cleaned_data.get('dlastname')
                    city= form.cleaned_data.get('dcity')
                    apartment= form.cleaned_data.get('dapartment')
                    streetaddress= form.cleaned_data.get('dstreetaddress')
                    zipcode= form.cleaned_data.get('dzipcode')
                    country= form.cleaned_data.get('billing_country')
                    phone= form.cleaned_data.get('dphone')
                    email = form.cleaned_data.get('demail')
                    if is_valid_form([ first_name, email, phone, streetaddress, city, country, zipcode]):
                    #if is_valid_form([ city,  zipcode, country]):
                        billing_address = Address(
                            user=self.request.user,
                            firstname = first_name,
                            lastname = last_name,
                            city = city,
                            apartment_address = apartment,
                            street_address = streetaddress,
                            country = country,
                            zipcode = zipcode,
                            phone = phone,
                            email = email,
                            address_type='B'
                        )
                        billing_address.save()
                        order.billing_address = billing_address
                        order.save()

                        set_default_billing = form.cleaned_data.get('set_default_billing')
                        if set_default_billing:
                            billing_address.default = True
                            billing_address.save()
                    else:
                        messages.info(self.request, "Please fill in the required billing address fields")
                
                payment_option = form.cleaned_data.get('payment_option')

                if payment_option == 'S':
                    return redirect('public:payment', payment_option='stripe')
                elif payment_option == 'C':
                    return redirect('public:payment', payment_option='COD')
                else:
                    messages.warning(self.request, "Invalid payment option selected")
                    return redirect('public:checkout')
        except ObjectDoesNotExist:
            messages.warning(self.request, "You do not have an active order")
            return redirect("/")


class PaymentView(View):
    def get(self, *args, **kwargs):
        order = Order.objects.get(user=self.request.user, ordered=False)
        if order.billing_address:
            context = {
                'order': order,
                'DISPLAY_COUPON_FORM': False
            }
            userprofile = self.request.user.userprofile
            if userprofile.one_click_purchasing:
                # fetch the users card list
                cards = stripe.Customer.list_sources(
                    userprofile.stripe_customer_id,
                    limit=3,
                    object='card'
                )
                card_list = cards[ 'data' ]
                if len(card_list) > 0:
                    # update the context with the default card
                    context.update({
                        'card': card_list[ 0 ]
                    })
            return render(self.request, "payment.html", context)
        else:
            messages.warning(
                self.request, "You have not added a billing address")
            return redirect("public:checkout")

    def post(self, *args, **kwargs):
        print(self.request.body)
        order = Order.objects.get(user=self.request.user, ordered=False)
        form = PaymentForm(self.request.POST)
        userprofile = UserProfile.objects.get(user=self.request.user)
        if form.is_valid():
            token = form.cleaned_data.get('stripeToken')
            save = form.cleaned_data.get('save')
            use_default = form.cleaned_data.get('use_default')
            if save:
                if userprofile.stripe_customer_id != '' and userprofile.stripe_customer_id is not None:
                    customer = stripe.Customer.retrieve(
                        userprofile.stripe_customer_id)
                    customer.sources.create(source=token)

                else:
                    customer = stripe.Customer.create(
                        email=self.request.user.email,
                    )
                    customer.sources.create(source=token)
                    userprofile.stripe_customer_id = customer[ 'id' ]
                    userprofile.one_click_purchasing = True
                    userprofile.save()

            amount = int(order.get_total() * 100)

            try:

                if use_default or save:
                    # charge the customer because we cannot charge the token more than once
                    charge = stripe.Charge.create(
                        amount=amount,  # cents
                        currency="INR",
                        customer=userprofile.stripe_customer_id
                    )
                else:
                    # charge once off on the token
                    charge = stripe.Charge.create(
                        amount=amount,  # cents
                        currency="INR",
                        source=token
                    )

                # create the payment
                payment = Payment()
                payment.stripe_charge_id = charge[ 'id' ]
                payment.user = self.request.user
                payment.amount = order.get_total()
                payment.save()

                # assign the payment to the order

                order_items = order.items.all()
                order_items.update(ordered=True)
                for item in order_items:
                    item.save()

                order.ordered = True
                order.payment = payment
                order.ref_code = create_ref_code()
                order.save()

                messages.success(self.request, "Your order was successful!")
                return redirect('public:OrderSuccessfully')

            except stripe.error.CardError as e:
                body = e.json_body
                err = body.get('error', {})
                messages.warning(self.request, f"{err.get('message')}")
                return redirect("/")

            except stripe.error.RateLimitError as e:
                # Too many requests made to the API too quickly
                messages.warning(self.request, "Rate limit error")
                return redirect("/")

            except stripe.error.InvalidRequestError as e:
                # Invalid parameters were supplied to Stripe's API
                print(e)
                messages.warning(self.request, "Invalid parameters")
                return redirect("/")

            except stripe.error.AuthenticationError as e:
                # Authentication with Stripe's API failed
                # (maybe you changed API keys recently)
                messages.warning(self.request, "Not authenticated")
                return redirect("/")

            except stripe.error.APIConnectionError as e:
                # Network communication with Stripe failed
                messages.warning(self.request, "Network error")
                return redirect("/")

            except stripe.error.StripeError as e:
                # Display a very generic error to the user, and maybe send
                # yourself an email
                messages.warning(
                    self.request, "Something went wrong. You were not charged. Please try again.")
                return redirect("/")

            except Exception as e:
                # send an email to ourselves
                messages.warning(
                    self.request, "A serious error occurred. We have been notifed.")
                return redirect("/")

        messages.warning(self.request, "Invalid data received")
        return redirect("/payment/stripe/")


# pending (DataBase and Connect handlling Task Goes Here)

def OrderSuccessfully(request):
    return render(request, 'orderSuccessfully.html')


class RequestRefundView(View):
    def get(self, *args, **kwargs):
        form = RefundForm()
        context = {
            'form': form
        }
        return render(self.request, "request_refund.html", context)

    def post(self, *args, **kwargs):
        form = RefundForm(self.request.POST)
        if form.is_valid():
            ref_code = form.cleaned_data.get('ref_code')
            message = form.cleaned_data.get('message')
            email = form.cleaned_data.get('email')
            # edit the order
            try:
                order = Order.objects.get(ref_code=ref_code)
                order.refund_requested = True
                order.save()

                # store the refund
                refund = Refund()
                refund.order = order
                refund.reason = message
                refund.email = email
                refund.save()

                messages.info(self.request, "Your request was received.")
                return redirect("public:request-refund")

            except ObjectDoesNotExist:
                messages.info(self.request, "This order does not exist.")
                return redirect("public:request-refund")



