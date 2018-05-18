"""djansite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from bearing import views
from rest_framework.authtoken import views as VIEW
from django.conf import settings

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^version$',views.version),
    url(r'^console$',views.console),
    url(r'^all/',views.componentGridAll),
       
######################### MAIN PAGE

    url(r'^$', views.index),

######################### VIEW
    url(r'^setUserPassword/',views.setUserPassword),
    url(r'^setSystemWebsite/',views.setSystemWebsite),
    url(r'^setSystemEmail/',views.setSystemEmail),
    url(r'^setUserInfo/',views.setUserInfo),
    url(r'^GridWaveletsmooth/',views.GridWaveletsmooth),
    url(r'^getWaveletDataToCsv/',views.getWaveletDataToCsv),
    url(r'^dealWaveletData/',views.dealWaveletData),
    url(r'^map/',views.Map),
    url(r'^role/',views.role),
    url(r'^testapi/',views.testapi),
    url(r'^appMessage/',views.appMessage),

       
########################USERLOGIN/REG/LOGOUT
    url(r'^login/', views.login,name='login'),
    url(r'^logout/', views.logout_view,name='logout'),
    url(r'^dealLogin/', views.dealLogin),
    url(r'^reg/', views.register),
    url(r'^user/captcha/$',views.captcha),
    
    # DEAL DATA
    url(r'^dealReg/', views.dealReg),
    url(r'^dealVerCode/',views.getPhoneSendVercode),
    url(r'^apiTokenAuth/$', VIEW.obtain_auth_token),
       
       
#######################
    url(r'^sensorData',views.sensorDataView),
    url(r'^sensorLiveData',views.sensorLiveData),
    url(r'^index$', views.index ,name ='home'),
    url(r'^api/getmem',views.saveInfo),

    url(r'^analysisData$',views.analysisData),
       
#####################View
    url(r'^analysisData$',views.analysisData), 
    url(r'^MaxMinData$',views.MaxMinData),
    url(r'^analysis$',views.analysis), 
    url(r'^ChoiceFactory/$',views.ChoiceFactory),

####################Upload Data
    url(r'^upLoadData$',views.upLoadData),
    url(r'^upLoadDataFrame$',views.upLoadDataFrame),


####################RASPDATA
    url(r'^raspiDashboard',views.raspiDashboard),
    url(r'^envriDashboard',views.envriDashboard),
    url(r'^HisRaspiDashboard',views.HisRaspiDashboard),
    url(r'^HisEnvriDashboard',views.HisEnvriDashboard),

#####################Manage
    url(r'^ManageFactory$',views.ManageFactory),
    url(r'^ManageRasp$',views.ManageRasp),
    url(r'^ManageSensor$',views.ManageSensor),


#####################api

    url(r'^api/getSensorData/$',views.getSensorData),
    url(r'^api/getSensor$',views.getSensor),
    url(r'^api/getMachine$',views.getMachine),
    url(r'^api/dealUserChange/',views.dealUserChange),
    url(r'^api/dealUserPasswrod/',views.dealUserPasswrod),
    url(r'^getOpcodeByMachineID$',views.getOpcodeByMachineID),
    url(r'^api/getNav$',views.getNav),
    url(r'^api/getDepart$',views.getDepart),
    url(r'^api/getMachineRunTime$',views.getMachineRunTime),
       
    # manage resp
    url(r'^api/getRaspInfo$',views.getRaspInfo),
    url(r'^api/addRaspInfo$',views.addRaspInfo),
    url(r'^api/delRaspInfo$',views.delRaspInfo),
    url(r'^api/getLastIDInRaspInfo$',views.getLastIDInRaspInfo),
    
    # manage factory 
    url(r'^api/getFactoryInfo$',views.getFactoryInfo),
    url(r'^api/addFactoryInfo$',views.addFactoryInfo),
    url(r'^api/delFactoryInfo$',views.delFactoryInfo),
    url(r'^api/getLastIDInFactoryInfo$',views.getLastIDInFactoryInfo),
    
    # manage Version
    url(r'^api/getLastIDInVersion$',views.getLastIDInVersion),
    url(r'^api/addVersionInfo$',views.addVersionInfo),
       
    # manage Sensor
    url(r'^api/getSensorInfo$',views.getSensorInfo),
     
       
    url(r'^api/getSensorDate$',views.getSensorDate),
    url(r'^api/getMinMaxData$',views.getMinMaxData),
    url(r'^api/getEveryMonthData$',views.getEveryMonthData),
    url(r'^api/getPersentData$',views.getPersentData),
       
    url(r'^api/getSensorHisData$',views.getSensorHisData),
#####################socket
    url(r'^socket/recRaspInfoSocket$',views.recRaspInfoSocket),
    url(r'^socket/sentRaspInfoSocket$',views.sentRaspInfoSocket),
    url(r'^socket/recTemHumSmogSocket',views.recTemHumSmogSocket),
    url(r'^socket/sentTemHumSmogSocket',views.sentTemHumSmogSocket),

#####################Iframe Content
    url(r'^addRaspInfo$',views.addRaspInfoContent),
    url(r'^addFactoryInfo$',views.addFactoryInfoContent),
    url(r'^addVersionContent$',views.addVersionContent),
    url(r'^addSensorContent$',views.addSensorContent),
       
    
    
]

