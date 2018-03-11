from django.shortcuts import render
from bearing.models import locationOne
from django.http import HttpResponse
from django.http import JsonResponse
import json
import sys
import datetime


# Create your views here.

def index(request):
    return render(request,'bearing/Layuilineboost.html')

def adminindex(request):
    return render(request,'bearing/index.html')

def adminlogin(request):
    return render(request,'bearing/adminlogin.html')


def dataView(request):
    ch = locationOne.objects.get(pk=1)
    return render(request,'bearing/dataView.html',{'ch':ch})

def ajax_dict(request):
    ## back type is QuerySet
    arr = []
    allch = locationOne.objects.all()
    for ch in allch:
        arr.append(ch.ch3)
    
    return JsonResponse(arr,safe=False)

def saveInfo(request):
    """
        这个方法就是我们的接口方法，
        当被请求时会将请求上来的数据存入数据库
    """
    statue = {}
    log_file = open("message.log", "a")
    sys.stdout = log_file
    if request.method == "POST" and request.POST: #检测请求的方式是post，并且post请求有数据
        #request.POST 这个方法以字典的形式存放着当前post请求的所有数据
        cpuUsed = request.POST["memUsed"] #使用类字典的取值方式取出传递上来的cpu使用率
        times = datetime.datetime.now() #获取当前时间
        print( str(times) + ':' +str(cpuUsed) + 'MB')
    
        statue["statue"] = "success" #定义当前接口状态为保存成功
    else:
        statue["statue"] = "request method must be post" #定义当前接口状态为失败
        print('fail')
    return JsonResponse(statue) #将接口状态返回给请求者
        
        
        
    