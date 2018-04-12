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
   
    
if __name__ == "__main__":
    #initInfo()
    #main()
    #test()
    #getRawData('1','1')
    #strrr = getIO()
    #insertData()
    Data()
    print('Done!')


