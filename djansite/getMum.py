# -*- coding: utf-8 -*-
import time
import urllib
import urllib.request
import requests

url = "http://127.0.0.1:8000/api/getmem/"

def getMem():
    with open('/proc/meminfo') as f:    
        total = int(f.readline().split()[1])
        free = int(f.readline().split()[1])
        buffers = int(f.readline().split()[1])
        cache = int(f.readline().split()[1])
    mem_use = total-free-buffers-cache
    mem_use = mem_use // 1024
    print('use mem:' + str(mem_use) + 'MB')
    
    data = {"memUsed":mem_use}
    
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
    #time.sleep(1)
    getMem()