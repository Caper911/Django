from django.shortcuts import render
from bearing.models import locationOne
from bearing.models import testInfo
from django.http import HttpResponse
from django.http import JsonResponse
import json
import sys
import datetime
import random

# Create your views here.

def index(request):
    return render(request,'bearing/Layuilineboost.html')

def adminindex(request):
    return render(request,'bearing/admin-index.html')

def adminlogin(request):
    return render(request,'bearing/adminlogin.html')

#pk primary key
def dataView(request):
    ch = locationOne.objects.get(pk=1)
    return render(request,'bearing/dataView.html',{'ch':ch})

def infoView(request):
    info = testInfo.objects.get(pk=1)
    return render(request,'bearing/dataView.html',{'ch':info})

def ajax_dict(request):
    ## back type is QuerySet
    arr = []
    
    #allch = locationOne.objects.all()
    allinfo = testInfo.objects.all()
    for info in allinfo:
        arr.append(info.num)
    
    return JsonResponse(arr,safe=False)


def get_last_info():
    arr = {}
    lastinfo = testInfo.objects.last()
    arr = {'info':lastinfo.info,'value':lastinfo.num,'time':str(lastinfo.time.strftime("%Y/%m/%d %H:%M:%S"))}
#    print('--------------------------------------------')
#    print(arr)
#    print('--------------------------------------------')
    return arr
    
def getlast19_info(request):
    
    infolist = []
    allinfo = testInfo.objects.order_by('-id')
    arr = allinfo[1:21]
    for arrinfo in arr:
        infolist.append(arrinfo.num)
        
    infolist.reverse()
    return JsonResponse(infolist,safe=False)

#ajax向服务器发出post请求，返回数据给ajax

def ajax_dict_realtime(request):

    info = get_last_info()
    #meminfo.append(random.random()*1000)
    return JsonResponse(info,safe=False) #将接口状态返回给请求者


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
        value = request.POST["memUsed"] #使用类字典的取值方式取出传递上来的cpu使用率
        info = request.POST['info']
        times = datetime.datetime.now() #获取当前时间
        print( str(times) + ':' +str(value) + 'MB')
        
        Info = testInfo(info = info,num=float(value),time=times)
        Info.save()

        statue["statue"] = "success" #定义当前接口状态为保存成功
    else:
        statue["statue"] = "request method must be post" #定义当前接口状态为失败
        print('fail')
    return JsonResponse(statue) #将接口状态返回给请求者
        
        
        
    
