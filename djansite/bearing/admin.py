from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User

# Register your models here.
from bearing.models import Profile,factory,productDepart,machine,sensorInfo,opStartEnddate,sensorRawData,sensorWaveletData,machineRunTime
from bearing.models import RaspbianInfo,TemHumConData,Version,Sensor
# Define an inline admin descriptor for Employee model
# which acts a bit like a singleton
class AdminInline(admin.StackedInline):
    model = Profile
    can_delete = False
    verbose_name_plural = 'admin'

# Define a new User admin
class UserAdmin(UserAdmin):
    inlines = (AdminInline, )

# Re-register UserAdmin
admin.site.unregister(User)
admin.site.register(User, UserAdmin)

admin.site.register(factory)
admin.site.register(productDepart)
admin.site.register(machine)
admin.site.register(sensorInfo)
admin.site.register(opStartEnddate)
admin.site.register(sensorRawData)
admin.site.register(sensorWaveletData)
admin.site.register(machineRunTime)
admin.site.register(RaspbianInfo)
admin.site.register(TemHumConData)
admin.site.register(Version)

admin.site.register(Sensor)