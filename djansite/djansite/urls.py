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

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$', views.index),
    url(r'^adminindex/',views.adminindex),
    url(r'^sensorData',views.sensorDataView),
    url(r'^index$', views.index ,name ='home'),
    url(r'^ajax_dict/$',views.ajax_dict,name='ajax_dict'),
    url(r'^ajax_dict_realtime/$',views.ajax_dict_realtime,),
    url(r'^login',views.adminlogin),
    url(r'^api/getmem',views.saveInfo),
    url(r'^ajax_19info/$',views.getlast19_info,name='ajax_19info'),
    url(r'^getCpuInfo_filter/$',views.getCpuInfo_filter),
    url(r'^getSensorInfo$',views.getSensorInfo),
]
