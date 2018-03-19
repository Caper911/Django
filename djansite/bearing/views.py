from django.shortcuts import render
from bearing.models import cpuInfo,memoryInfo,ioInfo
from bearing.models import sensorInfo,opStartEnddate,sensorData
from django.http import HttpResponse
from django.http import JsonResponse
import json
import sys
import datetime
import time
import random

# Create your views here.

def index(request):
    return render(request,'bearing/index.html')

def adminindex(request):
    return render(request,'bearing/admin-index.html')

def sensorDataView(request):
    return render(request,'bearing/sensorDataView.html')

def adminlogin(request):
    return render(request,'bearing/adminlogin.html')

#返回测试数据，用于增加图表的数据点
def ajax_dict(request):
    ## back type is QuerySet
    arr = []
    
    #allch = locationOne.objects.all()
    allinfo = testInfo.objects.all()
    for info in allinfo:
        arr.append(info.num)
    
    return JsonResponse(arr,safe=False)


def get_last_info(info):
    arr = {}
    
    if(info == 'cpu'):
        cpuinfo = cpuInfo.objects.last()
        arr = {'value':cpuinfo.value,'time':str(cpuinfo.time.strftime("%Y/%m/%d %H:%M:%S"))}   
    elif(info == 'mem'):
        meminfo = memoryInfo.objects.last()
        arr = {'valueUsed':meminfo.valueUsed,'memPercent':meminfo.memPercent,'time':str(meminfo.time.strftime("%Y/%m/%d %H:%M:%S"))}
    return arr
    

def getlast19_info(request):
    
    infolist = []
    allinfo = testInfo.objects.order_by('-id')
    arr = allinfo[1:21]
    for arrinfo in arr:
        infolist.append(arrinfo.num)
        
    infolist.reverse()
    return JsonResponse(infolist,safe=False)


def getSensorInfo(request):
    sensor_id = request.GET.get('opCodeID')
    sensor_name = request.GET.get('sensorName')
    arr = []
    eacharr = []
    if not sensor_id is None and not sensor_name is None:
        sensor_info = sensorData.objects.values(sensor_name,'time').filter(opCodeID=sensor_id)
        for info in sensor_info:
            eacharr.append((time.mktime(time.strptime(info['time'].strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
            eacharr.append(info[sensor_name])
            arr.append(eacharr)
            eacharr = []
    else:
        arr = []
    return JsonResponse(arr,safe=False)  


def getCpuInfo_filter(request):
    
    date_from  = request.GET.get('StartDate')
    date_to = request.GET.get('EndDate')
    arr = []
    eacharr = []
    
    if  date_from is None and  date_to is None:
        ALLcpuinfo = cpuInfo.objects.all()
        for cpuinfo in ALLcpuinfo:
            eacharr.append((time.mktime(time.strptime(cpuinfo.time.strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
            eacharr.append(cpuinfo.value)
            arr.append(eacharr)
            eacharr = []
    else:
        FilterCpuInfo = cpuInfo.objects.filter(time__range=(date_from,date_to))
        for cpuinfo in FilterCpuInfo:
            eacharr.append((time.mktime(time.strptime(cpuinfo.time.strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
            eacharr.append(cpuinfo.value)
            arr.append(eacharr)
            eacharr = []
    return JsonResponse(arr,safe=False)    
        
#ajax向服务器发出post请求，返回数据给ajax
def ajax_dict_realtime(request):
    
    info = request.GET.get('info')
    lastInfo = get_last_info(info)

    return JsonResponse(lastInfo,safe=False) #将接口状态返回给请求者

#接受从数据采集节点传送过来的数据，并保存到数据库中
def saveInfo(request):
    """
        这个方法就是我们的接口方法，
        当被请求时会将请求上来的数据存入数据库
    """
    statue = {}
    log_file = open("message.log", "a")
    
    #重定向标准输入输出
    sys.stdout = log_file
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST: 
        #request.POST 这个方法以字典的形式存放着当前post请求的所有数据
        
        CpuState = request.POST['CpuState']

        MemPercent = request.POST['MemPercent']
        MemUsed = request.POST['MemUsed']
        MemTotal = request.POST['MemTotal']
        
        #获取当前时间
        times = datetime.datetime.now() 
        print('CpuState(%):' + str(CpuState) + ' %\n' 
              + 'MemPercent(%):' + str(MemPercent) +' %\n' 
                           + 'MemUsed(MB):' + str(MemUsed) +' MB\n' 
                                     + 'MemTotal(MB):'+ str(MemTotal) +' MB\n')
        
        if not CpuState is None:
            CpuInfo = cpuInfo(value = float(CpuState),time = times)
            CpuInfo.save()
        if not MemPercent is None and not MemUsed is None:
            MemInfo = memoryInfo(valueUsed = float(MemUsed), memPercent = float(MemPercent), time = times)
            MemInfo.save()
        #定义当前接口状态为保存成功
        statue["statue"] = "request receive success" 
    else:
        #定义当前接口状态为失败
        statue["statue"] = "request method must be post" 
        print('fail')
     #将接口状态返回给请求者
    return JsonResponse(statue)
        
        
        
    
