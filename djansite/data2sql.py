#!/usr/bin/env python
#coding:utf-8

import os
import django,datetime
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djansite.settings")
from django.db.models import Q
django.setup()
import csv
import time
from bearing.models import factory as fact,productDepart,machine,sensorInfo,sensorRawData,opStartEnddate
''' 
##版本的判断
import django
if django.VERSION >= (1,7):
    django.setup()
'''

def initInfo():
    factorDes,location,areaCode,personInCharge,phoneNumber,otherInfo  = ('广州黄埔制造中心','广东省广州黄埔区大学路1号','440105','张博文','15622505458','负责制造转向器')
    info = fact.objects.create(factorDes=factorDes,location=location,areaCode=areaCode,
                           personInCharge=personInCharge,phoneNumber=phoneNumber,otherInfo=otherInfo)
   
    
    info = fact.objects.get(factorID='1001')
#    depatrDes,personInCharge,otherInfo,factory = ('生产部1','李慧语','负责试产转向器订单',info)
#    
#    depart = productDepart.objects.create( depatrDes= depatrDes,personInCharge=personInCharge,
#                            otherInfo=otherInfo,factory=factory)
#    
    depatrDes,personInCharge,otherInfo,factory = ('生产部2','李芳蔼','负责量产转向器订单',info)
    
    
    depart = productDepart.objects.create(departID='100002' ,depatrDes= depatrDes,personInCharge=personInCharge,
                            otherInfo=otherInfo,factory=factory)
    depart.save()
    
    depatrDes,personInCharge,otherInfo,factory  = ('检查部','李秦淮','负责检查转向器',info)  

    depart = productDepart.objects.create(departID='100003', depatrDes= depatrDes,personInCharge=personInCharge,
                            otherInfo=otherInfo,factory=factory)

    depart.save()

def main():
    csv_reader = csv.reader(open('DATA/original_data.csv', encoding='utf-8'))
    for row in csv_reader:
        DateTime = datetime.datetime.now()
        forceX, forceY, forceZ, shakeX, shakeY, shakeZ, acouEmission = row
        
        opCode =opStartEnddate.objects.get(opCodeID=2)

        
        info = RawData.objects.create(forceX=forceX,forceY=forceY,forceZ=forceZ,
                                             shakeX=shakeX,shakeY=shakeY,shakeZ=shakeZ,acouEmission=acouEmission,
                                             time=DateTime,opCodeID=opCode)
    info.save()
        
    
def getData():
    sensor_id = '2'
    sensor_name = 'acouEmission'
    eacharr = []
    if not sensor_id is None and not sensor_name is None:
        sensor_info = sensorData.objects.values(sensor_name,'time').filter(opCodeID=sensor_id)
        for info in sensor_info:
            eacharr.append(info[sensor_name])
    else:
        eacharr = []
    return eacharr


import pywt
import numpy as np
import seaborn
import matplotlib.pyplot as plt
from statsmodels.robust import mad

def waveletSmooth( x, wavelet="db4", level=1, title=None ):
    # calculate the wavelet coefficients
    coeff = pywt.wavedec( x, wavelet)
    # calculate a threshold
    sigma = mad( coeff[-level] )
    # changing this threshold also changes the behavior,
    # but I have not played with this very much
    uthresh = sigma * np.sqrt( 2*np.log( len( x ) ) )
    coeff[1:] = ( pywt.threshold( i, value=uthresh, mode="soft" ) for i in coeff[1:] )
    # reconstruct the signal using the thresholded coefficients
    y = pywt.waverec( coeff, wavelet)
    f, ax = plt.subplots()
    plt.plot( x, color="r", alpha=0.5 )
    plt.plot( y, color="b" )
    if title:
        ax.set_title(title)
    ax.set_xlim((0,len(y)))
    plt.show()
    return y

def test():
    data = getData()
    
    y=waveletSmooth(data)
    print(data)
    print(y)


    
def getSensorInfo(test):
    #sensor_id = request.GET.get('opCodeID')
    #sensor_name = request.GET.get('sensorName')
    arr = []
    eacharr = []
    

    sensor_id = 1
    sensor_name = 'forceX'
    sensor_info = sensorData.objects.values(sensor_name,'time').filter(opCodeID=sensor_id)
    for info in sensor_info:
        eacharr.append((time.mktime(time.strptime(info['time'].strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
        eacharr.append(info[sensor_name])
        arr.append(eacharr)
        eacharr = [] 
    
    print(arr)
    #查询字段的单值，为下拉框选项做选择
    infooo = sensorData.objects.values("id").distinct().all()
    for infffff in infooo:
        print(infffff['id'])    
    
def getRawData(sensorID,opcodeID):
    
    sensor = sensorInfo.objects.get(sensorID=sensorID)
    opStartEnd = opStartEnddate.objects.get(opCodeID=opcodeID)
    
    #Q(sensorInfo = sensor) & Q(opStartEnddate=opStartEnd)
    
    data = sensorRawData.objects.filter(Q(sensorInfo = sensor) & Q(opStartEnddate=opStartEnd))
    print(data)
    
def getIO():
    f = open('/proc/net/dev','r')
    for x in range(4):
        f.readline()
    line = f.readline()
    strline = line.split(' ')
    strline2 = []
    for a in strline:
        if a != ' ':
            if a!= '':
                strline2.append(a)
    return strline2

def insertData():
    
    csv_reader = csv.reader(open('DATA/original_data_3000.csv', encoding='utf-8'))
    
    machin = machine.objects.get(machineID = '1')
            
    AllSensor =  sensorInfo.objects.filter(machine=machin).values("sensorID","sensorCode").distinct()

    arr=list(AllSensor)

    for row in csv_reader:
        if len(arr) == len(row):
            for i in range(len(arr)):    
                sensor = sensorInfo.objects.get(sensorID=arr[i]['sensorID'])
                opStartEnd = opStartEnddate.objects.get(opCodeID='1')
                Data = sensorRawData.objects.create(sesorValue=row[i],sensorInfo = sensor,opStartEnddate=opStartEnd)
    Data.save() 

def Data():
    
    csv_reader = csv.reader(open('DATA/original_data_3000.csv', encoding='utf-8'))
    
    machin = machine.objects.get(machineID = '2')
            
    AllSensor =  sensorInfo.objects.filter(machine=machin).values("sensorID","sensorCode").distinct()

    arr=list(AllSensor)

    for row in csv_reader:

        for i in range(len(arr)):    
            sensor = sensorInfo.objects.get(sensorID=arr[i]['sensorID'])
            opStartEnd = opStartEnddate.objects.get(opCodeID='1')
            Data = sensorRawData.objects.create(sesorValue=row[i],sensorInfo = sensor,opStartEnddate=opStartEnd)
    Data.save()  
   

#树莓派上读取数据 循环发送
#在Django读取数据 存入redis中 
#网页端打开websocket 连接django 然后django 把数据发送到网页中 然后显示出来
import websocket
import psutil
import getpass

class rspi:
    USER = getpass.getuser()
    IP = psutil.net_if_addrs()['wlp8s0'][0][1]
    
    def CpuInfo(self):
        cpuNum = psutil.cpu_count()
        cpuPercent = psutil.cpu_percent(None)
        cpuEachPercent = psutil.cpu_percent(percpu = True)
        # current -> [1] highest -> [2]
        if len(psutil.sensors_temperatures()) ==0:
            cpuTemperature = 99
        else:
            cpuTemperature = psutil.sensors_temperatures()['coretemp'][0]
        
        return {'cpuNum':cpuNum,'cpuPercent':cpuPercent,
                'cpuEachPercent':cpuEachPercent,'cpuTemperature':cpuTemperature}
        
    def MemoryInfo(self):
        #virtual_memory
        virtual_memory = psutil.virtual_memory()
        virtual_total = virtual_memory[0] 
        virtual_available = virtual_memory[1] 
        virtual_percent = virtual_memory[2] 
        virtual_used = virtual_memory[3] 
        virtual_free = virtual_memory[4] 
        virtual_active = virtual_memory[5] 
        virtual_inactive = virtual_memory[6] 
        virtual_buffers = virtual_memory[7] 
        virtual_cached = virtual_memory[8] 
        virtual_shared = virtual_memory[9] 
        #swap_memory
        swap_memory = psutil.swap_memory()
        swap_total = swap_memory[0]
        swap_used = swap_memory[1]
        swap_free = swap_memory[2]
        swap_percent = swap_memory[3]
        
        return {'virtual_memory':virtual_memory,'swap_memory':swap_memory}
        
    def IOInfo(self):
        net_io_counters = psutil.net_io_counters()
        sent = net_io_counters[0]
        recv = net_io_counters[1]
        time.sleep(1)
        net_io_counters = psutil.net_io_counters()
        sent_1s = net_io_counters[0]
        recv_1s = net_io_counters[1]
        
        IO_sent_speed = sent_1s - sent
        IO_recv_speed = recv_1s - recv
        
        bytes_sent = psutil.net_io_counters()[0]
        bytes_recv = psutil.net_io_counters()[1]
                                           
        return {'bytes_sent':bytes_sent,'IO_sent_speed':IO_sent_speed,
                'bytes_recv':bytes_recv,'IO_recv_speed':IO_recv_speed}           
        
    def HardDiskInfo(self):
        
        disk_total = psutil.disk_usage('/')[0]
        disk_used = psutil.disk_usage('/')[1]
        disk_free = psutil.disk_usage('/')[2]
        disk_percent = psutil.disk_usage('/')[3]
    
        return {'disk_total':disk_total,'disk_used':disk_used,
                'disk_free':disk_free,'disk_percent':disk_percent} 


webSocketUrl = "ws://192.168.123.134:8000/socket/recRaspInfoSocket"
import json
def sentRspiData(webSocketUrl):
   
    reconnect = True

    while True:
        try:
            if reconnect:
                ws = websocket.create_connection(webSocketUrl)
            
            rspiInfo = rspi()
            info= {'datetime':time.strftime("%Y-%m-%d %H:%M:%S",time.localtime()),'user':rspiInfo.USER,'IP':rspiInfo.IP,'cpuInfo':rspiInfo.CpuInfo(),
                 'MemoryInfo':rspiInfo.MemoryInfo(),'IOInfo':rspiInfo.IOInfo(), 'HardDiskInfo':rspiInfo.HardDiskInfo() }
       
            ws.send(json.dumps(info))
            info['datetime'] =''
            reconnect = False
        except:
            print("connect error!")
            reconnect = True
            
    ws.close()
    
def count():
    allvalue = 193 + 199 + 190 +182 +171 
    allvalue += (156 + 167 +178 + 183 + 171 )
    allvalue += (180 + 168 + 173 +178+181)
    allvalue += (179 + 174 + 186 + 169 +175)
    allvalue += (177 + 174 + 195 + 167 + 171)
    allvalue += (179 + 184 + 181 + 170 + 172)
    allvalue += (196 + 169 + 172 + 170 + 172)
    allvalue += (185 + 180 + 175 + 176 +170 )
    allvalue += (169 + 182 + 171 + 172 + 173)
    allvalue += (170 + 179 + 183 + 178 + 104)
    
    value = 176 + 171 +171 +178 +172+177+169+175+181+176
    value += (166 + 172 +174+174+170+178+172+173+176+178)
    value += (171+164+174+174+176+169+168+168+170+167)
    value += (168+171+179+183)
    print(allvalue)
    print(value)

def gen_dates(b_date, days):
    day = datetime.timedelta(days=1)
    for i in range(days):
        yield b_date + day*i


def get_date_list(start=None, end=None):
    """
    获取日期列表
    :param start: 开始日期
    :param end: 结束日期
    :return:
    """
    if start is None:
        start = datetime.datetime.strptime("2000-01-01", "%Y-%m-%d")
    if end is None:
        end = datetime.datetime.now()
    data = []
    for d in gen_dates(start, (end-start).days):
        data.append(d)
    return data
    
    

if __name__ == "__main__":
    #initInfo()
    #main()
    #test()
    #getRawData('1','1')
    #strrr = getIO()
    #insertData()
    #Data()
    #count()
    print(get_date_list())
    #sentRspiData('ws://192.168.123.134:8000/socket/recRaspInfoSocket')
    print('Done!')


