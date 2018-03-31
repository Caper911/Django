#!/usr/bin/env python
#coding:utf-8

import os
import django,datetime
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djansite.settings")
django.setup()
import time
from bearing.models import sensorInfo,opStartEnddate,sensorData
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
    f = open('DATA/c_4_004.txt')
    for line in f:

        endDate = datetime.datetime.now()
        endDate = endDate + datetime.timedelta(seconds=1)
        print(endDate)
        time.sleep(1)
        opCode =opStartEnddate.objects.get(opCodeID=4)
        forceX, forceY, forceZ, shakeX, shakeY, shakeZ, acouEmission = line.split('	')
        
        info = sensorData.objects.create(forceX=forceX,forceY=forceY,forceZ=forceZ,
                                             shakeX=shakeX,shakeY=shakeY,shakeZ=shakeZ,acouEmission=acouEmission,
                                             time=endDate,opCodeID=opCode)
    info.save()
        
    f.close()
    
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
    #getOpcodeByMachineID('dongguan','4')
    print('Done!')


