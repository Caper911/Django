#!/usr/bin/env python
#coding:utf-8

import os
import django,datetime
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djansite.settings")
django.setup()
import csv
import time
from bearing.models import sensorInfo,opStartEnddate,sensorData,RawData
''' 
##版本的判断
import django
if django.VERSION >= (1,7):
    django.setup()
'''

def initInfo():
    sensorID = 'huizhouM12'
    location = 'huizhou'
    description = r'Three axis vibration / force sensor and acoustic emission sensor'
    addDate = datetime.datetime.now()
    MachineID = 2
    
    startDate = datetime.datetime.now()
    endDate = datetime.datetime.now()+datetime.timedelta(minutes=10)
    
    infoo = sensorInfo.objects.create(sensorID=sensorID,location=location,description=description,
                            addDate=addDate,machineID=MachineID)
    infoo.save()
    
    info = opStartEnddate.objects.create(startDate=startDate,endDate=endDate,sensorID=infoo)
    time.sleep(2)
    
    startDate = datetime.datetime.now()
    endDate = datetime.datetime.now()+datetime.timedelta(minutes=10)
    info = opStartEnddate.objects.create(startDate=startDate,endDate=endDate,sensorID=infoo)
    info.save()
    


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
    
def getOpcodeByMachineID(location,machineID):
    machineID = machineID
    location = location
    
    machineData = sensorInfo.objects.all().filter(location=location)
    machineID = machineData.filter(machineID=machineID)
    for machine in machineID:

        info = opStartEnddate.objects.prefetch_related().filter(sensorID=machine)
        for inff in info:
            print(inff.opCodeID)
   

if __name__ == "__main__":
    #initInfo()
    main()
    #test()
    #getOpcodeByMachineID('dongguan','4')
    print('Done!')


