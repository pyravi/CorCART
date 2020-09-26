from itertools import chain
from django.views.generic import ListView
from .models import (
    Item,
    Category,
    Slider
    )


class SearchView(ListView):
    template_name = 'search.html'
    paginate_by = 20
    count = 0
    
    def get_context_data(self, *args, **kwargs):
        context = super().get_context_data(*args, **kwargs)
        context['count'] = self.count or 0
        context['query'] = self.request.GET.get('search')
        context['category'] = Category.objects.all()
        context['slider'] = Slider.objects.all()
        return context
    
    def get_queryset(self):
        request = self.request
        query = request.GET.get('search', None)
        
        if query is not None:
            #category_results = Category.objects.search(query)
            items_results    = Item.objects.search(query)

            print(items_results)
            # combine querysets 
            queryset_chain = chain(
                    #category_results,
                    items_results
            )        
            qs = sorted(queryset_chain, 
                        key=lambda instance: instance.pk, 
                        reverse=True)
            self.count = len(qs) # since qs is actually a list
            return qs
        return Item.objects.none() # just an empty queryset as default





















# from PIL import Image
# im = Image.open("zoom_0-1543323686.webp").convert("RGB")
# im.save('test.jpg','jpeg')
# #if width is heigth is vary
# import PIL
# from PIL import Image
# basewidth = 300
# img = Image.open(‘fullsized_image.jpg')
# wpercent = (basewidth / float(img.size[0]))
# hsize = int((float(img.size[1]) * float(wpercent)))
# img = img.resize((basewidth, hsize), PIL.Image.ANTIALIAS)
# img.save('resized_image.jpg')
# heigth fix and width is proportionally variable
# baseheight = 560
# img = Image.open(‘fullsized_image.jpg')
# hpercent = (baseheight / float(img.size[1]))
# wsize = int((float(img.size[0]) * float(hpercent)))
# img = img.resize((wsize, baseheight), PIL.Image.ANTIALIAS)
# img.save('resized_image.jpg')