from django.db import models

# Create your models here.

class locationOne(models.Model):
    ch1 = models.FloatField()
    ch2 = models.FloatField()
    ch3 = models.FloatField()
    ch4 = models.FloatField()
    ch5 = models.FloatField()
    ch6 = models.FloatField()
    ch7 = models.FloatField()
    ch8 = models.FloatField()
    
    
class testInfo(models.Model):
    #info = models.FloatField()
    info = models.CharField(max_length=30)
    num = models.FloatField()
    time = models.DateTimeField()
    

    
class User(models.Model):
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    
    def __unicode__(self):
        return self.username