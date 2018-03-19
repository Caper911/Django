from django.db import models

# Create your models here.

class sensorInfo(models.Model):
    sensorID = models.CharField(primary_key=True,max_length=20)
    location = models.CharField(max_length=10)
    description = models.CharField(max_length=100)
    addDate = models.DateField()
    machineID = models.IntegerField()   
    
class opStartEnddate(models.Model):    
    opCodeID = models.AutoField(primary_key=True)
    startDate = models.DateField()
    endDate = models.DateField()
    sensorID = models.ForeignKey(sensorInfo)
    
class sensorData(models.Model):
    forceX = models.FloatField()
    forceY = models.FloatField()
    forceZ = models.FloatField()
    shakeX = models.FloatField()
    shakeY = models.FloatField()
    shakeZ = models.FloatField()
    acouEmission = models.FloatField()
    time = models.DateTimeField()
    opCodeID = models.ForeignKey(opStartEnddate)
    
class testInfo(models.Model):
    #info = models.FloatField()
    info = models.CharField(max_length=30)
    num = models.FloatField()
    time = models.DateTimeField()
    
class cpuInfo(models.Model):
    value = models.FloatField()
    time = models.DateTimeField()
    
class memoryInfo(models.Model):
    valueUsed = models.FloatField()
    memPercent = models.FloatField()
    time = models.DateTimeField()

class ioInfo(models.Model):
    value = models.FloatField()
    time = models.DateTimeField()
        
class User(models.Model):
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    
    def __unicode__(self):
        return self.username