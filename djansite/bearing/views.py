from django.shortcuts import render
from bearing.models import locationOne
# Create your views here.
def index(request):
    return render(request,'bearing/Layui.html')

def dataView(request):
    ch = locationOne.objects.get(pk=1)
    return render(request,'bearing/dataView.html',{'ch':ch})