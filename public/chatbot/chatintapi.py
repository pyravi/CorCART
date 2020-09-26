from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse,HttpResponse
from django.utils.decorators import method_decorator
from public.models import Category,Item
import json
from .library.df_response_lib import *
from django.core.exceptions import ObjectDoesNotExist
                              
@csrf_exempt
def chat(request):
    #Respone from web webhook
    data=json.loads(request.body)
    intent=json.loads(request.body).get('queryResult').get('intent').get('displayName')
    parameter = json.loads(request.body).get('queryResult').get('parameters') 
    print(f'{intent} and {parameter}')
    #Category Filter
    if 'all_category' == intent:
        #results =Category.objects.root_nodes()
        results =Category.objects.filter(parent_id=None)
        catlist=[]
        for i in results:
            str(catlist.append(i.name)) 
        categoryNumber=len(results)
        return JsonResponse({"fulfillmentMessages":[{"payload":{"richContent":[[{"type":"description","title":"No of "+str(categoryNumber)+" Categories available on this site","text":catlist}]]}}]})
    #Product Filter
    elif 'ProductPrice' ==intent:
        #value=list(parameter.values())[1]
        value=parameter['items']
        try:
            results =Item.objects.get(product_title=value)
            return JsonResponse({
                    "fulfillmentMessages": [
                      {
                        "payload": {
                          "richContent": [
                            [
                              {
                                "type": "image",
                                "rawUrl": "../media/{}".format(results.product_image),
                                "accessibilityText": str(results.product_title)
                              },
                              {
                                "type": "info",
                                "title": str(results.product_title),
                                "subtitle": str(results.product_description),
                                "actionLink": "../product/{}".format(results.product_slug)
                              },
                              {
                                "type": "chips",
                                "options": [
                                  {
                                    "text": "Add To Cart",
                                    "link": "../add-to-cart/{}".format(results.product_slug)
                                  },
                                  {
                                    "text": "Buy Now",
                                    "link": "../checkout"
                                  }
                                ]
                              }
                            ]
                          ]
                        }
                      }
                    ]
                    }
                    )
        except ObjectDoesNotExist:
            return JsonResponse({"fulfillmentText": str(value) +' is not avaliable on this Site'})
    #No Validate any intent here
    else:
        return JsonResponse({"fulfillmentText": "Not service of this time"})
