from django.shortcuts import render
from bearing.models import locationOne
from django.http import HttpResponse
import json
# Create your views here.

def index(request):
    return render(request,'bearing/Layui.html')

def dataView(request):
    ch = locationOne.objects.get(pk=1)
    return render(request,'bearing/dataView.html',{'ch':ch})

def getData(request):
    ## back type is QuerySet
    arr = []
    allch = locationOne.objects.all()
    for ch in allch:
        arr.append(ch.ch1)
    
    return HttpResponse(json.dumps(arr))
        
        
        
    