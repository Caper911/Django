from django.shortcuts import render
from bearing.models import locationOne
from django.http import HttpResponse
from django.http import JsonResponse
import json
# Create your views here.

def index(request):
    return render(request,'bearing/Layuilineboost.html')

def adminindex(request):
    return render(request,'bearing/admin-index.html')

def dataView(request):
    ch = locationOne.objects.get(pk=1)
    return render(request,'bearing/dataView.html',{'ch':ch})

def ajax_dict(request):
    ## back type is QuerySet
    arr = []
    allch = locationOne.objects.all()
    for ch in allch:
        arr.append(ch.ch2)
    
    return JsonResponse(arr,safe=False)
        
        
        
    