from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.conf import settings
import django.utils.timezone as timezone
import time
from rest_framework.authtoken.models import Token

# Create your models here.
#
class factory(models.Model):
    class Meta:
        verbose_name = '制造加工厂'
        verbose_name_plural = '制造加工厂' 
    factorID = models.AutoField('部门编码',primary_key=True)
    factorDes = models.CharField('部门描述',max_length=100)
    location = models.CharField('地址',max_length=200)
    areaCode = models.CharField('区域代码',max_length=6)
    personInCharge = models.CharField('责任人',max_length=12)
    phoneNumber = models.CharField('手机号码',max_length=11,blank=True)
    otherInfo = models.TextField('备注 ',null=True,blank=True)
    saveDate = models.DateTimeField('保存日期',default = timezone.now)
    modDate = models.DateTimeField('最后修改日期', auto_now = True)
    
    def __str__(self):
        return self.factorDes

class productDepart(models.Model):
    class Meta:
        verbose_name = '生产部门'
        verbose_name_plural = '生产部门' 
    departID = models.AutoField(primary_key=True)
    depatrDes = models.CharField(max_length=100)
    personInCharge = models.CharField(max_length=12)
    otherInfo = models.TextField(null=True,blank=True)
    saveDate = models.DateTimeField('保存日期',default = timezone.now)
    modDate = models.DateTimeField('最后修改日期', auto_now = True)
    factory = models.ForeignKey(factory)
    
    def __str__(self):
        return self.factory.factorDes + self.depatrDes

class opStartEnddate(models.Model):
    class Meta:
        verbose_name = '操作代号/时间'
        verbose_name_plural = '操作代号/时间'    
    opCodeID = models.AutoField(primary_key=True)
    startDate = models.DateTimeField()
    endDate = models.DateTimeField()
    def __str__(self):
        return str(self.startDate)[0:19]+' - '+str(self.endDate)[0:19]

class machine(models.Model):
    class Meta:
        verbose_name = '机床'
        verbose_name_plural = '机床' 
    machineID = models.AutoField('机床编码',primary_key=True)
    machineDes = models.CharField('机床描述',max_length=100)
    saveDate = models.DateTimeField('保存日期',default = timezone.now)
    modDate = models.DateTimeField('最后修改日期', auto_now = True)
    otherInfo = models.TextField('备注 ',null=True,blank=True)
    productDepart = models.ForeignKey(productDepart)

    def __str__(self):
        return self.productDepart.depatrDes + self.machineDes

class machineRunTime(models.Model):
    class Meta:
        verbose_name = '铣床运行时间段'
        verbose_name_plural = '铣床运行时间段' 
    machine = models.ForeignKey(machine)
    opStartEnddate = models.ForeignKey(opStartEnddate)
    def __str__(self):
        return self.machine.machineDes +' - '+ str(self.opStartEnddate.opCodeID)
    
    
class sensorInfo(models.Model):
    class Meta:
        verbose_name = '传感器信息'
        verbose_name_plural = '传感器信息' 
    sensorID = models.AutoField(primary_key=True)
    sensorCode = models.CharField('传感器编码',max_length=15,null=True,blank=True)
    dsensorDes = models.CharField('传感器描述',max_length=50,null=True,blank=True)
    machine = models.ForeignKey(machine,null=True)
    saveDate = models.DateTimeField('保存日期',default = timezone.now)
    modDate = models.DateTimeField('最后修改日期', auto_now = True)
    def __str__(self):
        return self.dsensorDes

   

    
class sensorRawData(models.Model):
    class Meta:
        verbose_name = '传感器源数据'
        verbose_name_plural = '传感器源数据' 
        ordering = ['saveDate']
    sensorID = models.AutoField(primary_key=True)
    sesorValue = models.FloatField('数值')
    saveDate = models.DateTimeField('保存日期',default = timezone.now)
    sensorInfo = models.ForeignKey(sensorInfo)
    opStartEnddate = models.ForeignKey(opStartEnddate)
    def __str__(self):
        return str(self.opStartEnddate.opCodeID)+'.'+self.sensorInfo.dsensorDes +':'+ str(self.sesorValue)
#从sensorRawData表中读取源数据处理后生成小波数据，并存入sensorWaveletData中
class sensorWaveletData(models.Model):
    class Meta:
        verbose_name = '小波去噪后数据'
        verbose_name_plural = '小波去噪后数据' 
        ordering = ['saveDate']
    
    sensorID = models.AutoField(primary_key=True)
    sesorValue = models.FloatField('数值')
    saveDate = models.DateTimeField('保存日期',default = timezone.now)
    sensorInfo = models.ForeignKey(sensorInfo)
    opStartEnddate = models.ForeignKey(opStartEnddate)   
    


class cpuInfo(models.Model):
    value = models.FloatField()
    time = models.DateTimeField()
    machine = models.ForeignKey(machine,null=True)
    
class memoryInfo(models.Model):
    valueUsed = models.FloatField()
    memPercent = models.FloatField()
    time = models.DateTimeField()
    machine = models.ForeignKey(machine,null=True)

class ioInfo(models.Model):
    value = models.FloatField()
    time = models.DateTimeField()
    machine = models.ForeignKey(machine,null=True)
        

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phonenumber = models.CharField(max_length=11,blank=True)
    avatar = models.ImageField(upload_to='photo',null=True,blank=True)
#   0、未知，1、男，2、女，3、女改男，4、男改女，5、其他
    gender = models.IntegerField(default = 0)
    otherText = models.TextField(null=True,blank=True)
#    password = models.CharField(max_length=32)
#    email = models.EmailField(blank=True)

#    is_active = models.BooleanField(default=False)
#    

# 为每个用户添加token值
@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)
        
# 为每个用户添加token值
@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
 
@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()

