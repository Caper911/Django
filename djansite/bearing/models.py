from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver


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
    
class RawData(models.Model):
    forceX = models.FloatField()
    forceY = models.FloatField()
    forceZ = models.FloatField()
    shakeX = models.FloatField()
    shakeY = models.FloatField()
    shakeZ = models.FloatField()
    acouEmission = models.FloatField()
    time = models.DateTimeField()
    opCodeID = models.ForeignKey(opStartEnddate)

#从RawData表中读取源数据处理后生成小波数据，并存入WaveletData中
class WaveletData(models.Model):
    forceX = models.FloatField()
    forceY = models.FloatField()
    forceZ = models.FloatField()
    shakeX = models.FloatField()
    shakeY = models.FloatField()
    shakeZ = models.FloatField()
    acouEmission = models.FloatField()
    time = models.DateTimeField()
    opCodeID = models.ForeignKey(opStartEnddate)
    
    
    
#class testInfo(models.Model):
#    #info = models.FloatField()
#    info = models.CharField(max_length=30)
#    num = models.FloatField()
#    time = models.DateTimeField()
#    
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
        

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phonenumber = models.CharField(max_length=11,blank=True)
    avatar = models.ImageField(upload_to='photo',null=True,blank=True)
#    id = models.AutoField(primary_key=True)
#    username = models.CharField(max_length=16,primary_key=True)
#    password = models.CharField(max_length=32)
#    email = models.EmailField(blank=True)

#    is_active = models.BooleanField(default=False)
#    


@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)
 
@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()

