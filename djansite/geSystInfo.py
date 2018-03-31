# -*- coding: utf-8 -*-
import time
import urllib
import urllib.request
import requests

url = "http://127.0.0.1:8000/api/getmem/"
#url = "http://23.105.197.30:8080/api/getmem/"
import psutil


#function of Get cpu state
def getCPUstate(interval=1):
    return psutil.cpu_percent(interval)


#function of Get Mem percent/Used/Total
def getMemorystate():
    phymem = psutil.virtual_memory()
    line = "Memory: %5s%% %6s/%s"%(
            phymem.percent,
            str(int(phymem.used/1024/1024))+"M",
            str(int(phymem.total/1024/1024))+"M"
            )
    return line

def PostInfo():
    
    CpuState = psutil.cpu_percent(None)
    phymem = psutil.virtual_memory()
    MemPercent = phymem.percent
    MemUsed = int(phymem.used/1024/1024)
    MemTotal = int(phymem.total/1024/1024)

    
    data = {"CpuState":CpuState,"MemPercent":MemPercent,"MemUsed":MemUsed,"MemTotal":MemTotal,}
    
    print(data)
#定义请求头部
    header = {
        "User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
    }
    
    res = requests.post(url,data = data,headers = header,)
    status_code = res.status_code
    
    if(status_code == 200):
        print('status code : 200,sucess!')
    else:
        print('status code : '+ str(status_code) + ',sucess!')
    
while True:
    time.sleep(1)
    PostInfo()