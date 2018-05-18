from django.shortcuts import render

from bearing.models import cpuInfo,memoryInfo,ioInfo,TemHumConData

from bearing.models import factory,productDepart,machine,sensorInfo,opStartEnddate,machineRunTime
from bearing.models import sensorRawData,sensorWaveletData
from bearing.models import RaspbianInfo,Version,Sensor

from django.contrib.auth import authenticate,login,logout
from django.contrib import auth
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required

from django.http import HttpResponse
from django.http import JsonResponse

import sys
import datetime
import time
import random
from django.db.models import Q
from dwebsocket.decorators import accept_websocket, require_websocket


from django.db import connection
from django.db.models import Avg ,Max,Min

# Create your views here.
@login_required 
def index(request):
    return render(request,'bearing/views/index.html')


def console(request):
    return render(request,'bearing/views/home/console.html')

###############################################################
def version(request):
    AllInfo = Version.objects.all()
    return render(request,'bearing/views/home/version.html',{'AllInfo': AllInfo})

# ADD A Version INFO
# 

def addVersionInfo(request):
    arr = {"code":200,"msg":"版本信息更新成功!","data":{}}
    
    if request.method == "POST" and request.POST:

        VersionID = request.POST['VersionID']
        version = request.POST['Version']
        VersionContent = request.POST['VersionContent']
        UpdatePerson = request.POST['UpdatePerson']
        
        info = Version.objects.create(VersionID=VersionID,Version=version,VersionContent=VersionContent,UpdatePerson=UpdatePerson)
        info.save()
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)

# Get last ID IN RaspInfo

def getLastIDInVersion(request):
    arr = {"code":200,"msg":"获取编号成功！","data":{}}
    if request.method == "POST":
        ID = 0
        info = Version.objects.first()
        if info is None:
            ID = 1
        else:
            ID = info.VersionID + 1
            
        arr['data']['ID'] = ID
        print(ID)
           
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)
    
    


def login(request):
    return render(request,'bearing/views/user/login.html')

def logout_view(request):

    arr = {"code": 0,"msg": "退出成功","data": {}}
    if 'username' in request.session:    
        del request.session['username']
        
    logout(request)

    return JsonResponse(arr,safe=False)

def register(request):
    return render(request,'bearing/views/user/reg.html')

def componentGridAll(request):
    return render(request,'bearing/views/component/grid/all.html')

def appMessage(request):
    return render(request,'bearing/views/app/message/index.html')

############################## iframe

def ChoiceFactory(request):
    return render(request,'bearing/views/iframe/choiceFactory.html')

def addRaspInfoContent(request):
    return render(request,'bearing/views/iframe/addRaspInfo.html')

def addFactoryInfoContent(request):
    return render(request,'bearing/views/iframe/addFactoryInfo.html')

def addVersionContent(request):
    return render(request,'bearing/views/iframe/addVersion.html')

def addSensorContent(request):
    return render(request,'bearing/views/iframe/addSensor.html')

def upLoadData(request):
    return render(request,'bearing/views/component/grid/UploadData.html')

def upLoadDataFrame(request):
    return render(request,'bearing/views/iframe/UploadData.html')

#################################################################

def GridWaveletsmooth(request):
    return render(request,'bearing/views/component/grid/waveletSmooth.html')

def Map(request):
    return render(request,'bearing/views/map/map.html')


####################################################################

def raspiDashboard(request):
    return render(request,'bearing/views/raspi/dashboard.html')

def envriDashboard(request):
    return render(request,'bearing/views/raspi/envridashboard.html')

def HisRaspiDashboard(request):
    return render(request,'bearing/views/raspi/Hisdashboard.html')

def HisEnvriDashboard(request):
    return render(request,'bearing/views/raspi/Hisenvridashboard.html')

#####################################################################


def testapi(request):
    data = {"code":0,"msg":"","count":1000,"data":[{"id":10000,"username":"user-0","sex":"女","city":"城市-0","sign":"签名-0","experience":255,"logins":24,"wealth":82830700,"classify":"作家","score":57},{"id":10001,"username":"user-1","sex":"男","city":"城市-1","sign":"签名-1","experience":884,"logins":58,"wealth":64928690,"classify":"词人","score":27},{"id":10002,"username":"user-2","sex":"女","city":"城市-2","sign":"签名-2","experience":650,"logins":77,"wealth":6298078,"classify":"酱油","score":31},{"id":10003,"username":"user-3","sex":"女","city":"城市-3","sign":"签名-3","experience":362,"logins":157,"wealth":37117017,"classify":"诗人","score":68},{"id":10004,"username":"user-4","sex":"男","city":"城市-4","sign":"签名-4","experience":807,"logins":51,"wealth":76263262,"classify":"作家","score":6},{"id":10005,"username":"user-5","sex":"女","city":"城市-5","sign":"签名-5","experience":173,"logins":68,"wealth":60344147,"classify":"作家","score":87},{"id":10006,"username":"user-6","sex":"女","city":"城市-6","sign":"签名-6","experience":982,"logins":37,"wealth":57768166,"classify":"作家","score":34},{"id":10007,"username":"user-7","sex":"男","city":"城市-7","sign":"签名-7","experience":727,"logins":150,"wealth":82030578,"classify":"作家","score":28},{"id":10008,"username":"user-8","sex":"男","city":"城市-8","sign":"签名-8","experience":951,"logins":133,"wealth":16503371,"classify":"词人","score":14},{"id":10009,"username":"user-9","sex":"女","city":"城市-9","sign":"签名-9","experience":484,"logins":25,"wealth":86801934,"classify":"词人","score":75}]}
    return JsonResponse(data,safe=False)

def role(request):
    return render(request,'bearing/views/authority/role.html')



###########################
##
#analysisData

def analysisData(request):
    Temdata = "Date,Time,Temperature\n"
    Humdata = "Date,Time,Humidity\n"
    Temresult = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)','day':'day(saveDate)','hour':'hour(saveDate)'}).values('year','month','day','hour').annotate(TemMax=Max('TemValue'),TemMin=Min('TemValue'),TemAvg=Avg('TemValue'))
    Humresult = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)','day':'day(saveDate)','hour':'hour(saveDate)'}).values('year','month','day','hour').annotate(TemMax=Max('HumValue'),TemMin=Min('HumValue'),TemAvg=Avg('HumValue'))
    for info in Temresult:
        data = str(info['year'])+'-'+str(info['month'])+'-'+str(info['day'])+','+str(info['hour'])+','+str(round(info['TemAvg'],1))+'\n'
        Temdata+=data
        
    for info in Humresult:
        data = str(info['year'])+'-'+str(info['month'])+'-'+str(info['day'])+','+str(info['hour'])+','+str(round(info['TemAvg'],1))+'\n'
        Humdata+=data
    
    
    return render(request,'bearing/views/analysisData/index.html', {'Temdata': Temdata[:-1],'Humdata':Humdata[:-1]})


def MaxMinData(request):
    return render(request,'bearing/views/analysisData/MaxMin.html')

def analysis(request):
    
    data = getReport()
    
    return render(request,'bearing/views/analysisData/analysisData.html',{'data': data})


###########################
##
#Manage

def ManageFactory(request):
    return render(request,'bearing/views/manage/managefactory.html')

def ManageRasp(request):
    return render(request,'bearing/views/manage/managerasp.html')

def ManageSensor(request):
    return render(request,'bearing/views/manage/managesensor.html')


###############################################
##
#Set User Info

@login_required 
def setUserInfo(request):
    return render(request,'bearing/views/set/user/info.html')

@login_required 
def setUserPassword(request):
    return render(request,'bearing/views/set/user/password.html')

def setSystemWebsite(request):
    return render(request,'bearing/views/set/system/website.html')

def setSystemEmail(request):
    return render(request,'bearing/views/set/system/email.html')

#######################################################################################
#账号密码登录处理函数
#{
#  "code": 0
#  ,"msg": "登入成功"
#  ,"data": {
#    "access_token": "c262e61cd13ad99fc650e6908c7e5e65b63d2f32185ecfed6b801ee3fbdd5c0a"
#  }
#}

def dealLogin(request):
    arr = {"code":0,"msg":"登录成功!","data":{}}

    if request.method == "POST" and request.POST:
        vercode = request.POST['vercode']
        print(vercode)
        print(request.session['VerCodeKey'].upper())
        if vercode.upper() == request.session['VerCodeKey'].upper():
            
            if 'fav_color' in request.session:
               del request.session['VerCodeKey']  
            
            username = request.POST['username']
            password = request.POST['password']
            
            result = authenticate(username=username,password=password)
            
            if result is not None and result.is_active:
                request.session["username"] = result.username
                request.session["phonenumber"] = result.profile.phonenumber
                request.session["name"] = result.first_name
                request.session["gender"]  = result.profile.gender           
                request.session["otherText"] = result.profile.otherText
                request.session["email"] = result.email              
                auth.login(request,result)
                
                return JsonResponse(arr,safe=False)
            
            else:
                arr['code'] = 1
                arr['msg'] = "用户名或密码不正确!"
                return JsonResponse(arr,safe=False)
        else:
            arr['code'] = 1
            arr['msg'] = "验证码不正确，请重新尝试!"
    else:
        arr['code'] = 1
        arr['msg'] = "请求方式错误，需POST方法."
    
    return JsonResponse(arr,safe=False)

#######################################################################################
#用户信息修改处理函数
#{
#  "code": 0
#  ,"msg": "信息修改成功!
#  ,"data": {
#    
#  }
#}

def dealUserChange(request):
    arr = {"code":0,"msg":"信息修改成功!","data":{}}

    if request.method == "POST" and request.POST and request.user.is_authenticated:
            
            user = User.objects.get(username=request.user.get_username())
            
            if user is not None :
                user.profile.phonenumber = request.POST['cellphone']
                user.first_name = request.POST['nickname']
                user.profile.otherText = request.POST['remarks']
                user.email = request.POST['email']
                if request.POST['sex'] == '女':
                    user.profile.gender = 2
                elif request.POST['sex'] == '男':
                    user.profile.gender = 1
                elif request.POST['sex'] == '其他':
                    user.profile.gender = 0
                user.save()
                
                request.session["phonenumber"] = user.profile.phonenumber
                request.session["name"] = user.first_name
                request.session["gender"]  = user.profile.gender  
                request.session["otherText"] = user.profile.otherText
                request.session["email"] = user.email 
                
                return JsonResponse(arr,safe=False)         
            else:
                arr['code'] = 1
                arr['msg'] = "未知错误，联系管理员!"
                return JsonResponse(arr,safe=False)

    else:
        arr['code'] = 1
        arr['msg'] = "请求方式错误，需POST方法."
    
    return JsonResponse(arr,safe=False)

#######################################################################################
#用户密码修改函数函数
#{
#  "code": 0
#  ,"msg": "密码修改成功！"
#  ,"data": {
#    
#  }
#}

def dealUserPasswrod(request):
    arr = {"code":0,"msg":"密码修改成功，请重新登录！","data":{}}

    if request.method == "POST" and request.POST and request.user.is_authenticated:
            
            password = request.POST['oldPassword']

            user = authenticate(username=request.user.get_username(),password=password)
           
            if user is not None :
                newPassword = request.POST['password']
                
                user.set_password(newPassword)
                
                user.save()
                
                return JsonResponse(arr,safe=False)         
            else:
                arr['code'] = 1
                arr['msg'] = "旧密码输入错误，请重新输入！"
                return JsonResponse(arr,safe=False)

    else:
        arr['code'] = 1
        arr['msg'] = "请求方式错误，需POST方法."
    
    return JsonResponse(arr,safe=False)

#############################################################################
#发送短信验证码

from aliyunsdkdysmsapi.request.v20170525 import SendSmsRequest
from aliyunsdkdysmsapi.request.v20170525 import QuerySendDetailsRequest
from aliyunsdkcore.client import AcsClient
import uuid
from aliyunsdkcore.profile import region_provider
from aliyunsdkcore.http import method_type as MT
from aliyunsdkcore.http import format_type as FT
REGION = "cn-hangzhou"
PRODUCT_NAME = "Dysmsapi"
DOMAIN = "dysmsapi.aliyuncs.com"

#KEY
ACCESS_KEY_ID = "LTAIvbcX5vUXfuks"
ACCESS_KEY_SECRET = "vqI59V7EBVTY0ZeaUOphmIOaEJOEeD"

acs_client = AcsClient(ACCESS_KEY_ID, ACCESS_KEY_SECRET, REGION)
region_provider.add_endpoint(PRODUCT_NAME, REGION, DOMAIN)

def send_sms(business_id, phone_numbers, sign_name, template_code, template_param=None):
    smsRequest = SendSmsRequest.SendSmsRequest()
    # 申请的短信模板编码,必填
    smsRequest.set_TemplateCode(template_code)

    # 短信模板变量参数
    if template_param is not None:
        smsRequest.set_TemplateParam(template_param)

    # 设置业务请求流水号，必填。
    smsRequest.set_OutId(business_id)

    # 短信签名
    smsRequest.set_SignName(sign_name)
	
    # 数据提交方式
	# smsRequest.set_method(MT.POST)
	
	# 数据提交格式
    # smsRequest.set_accept_format(FT.JSON)
	
    # 短信发送的号码列表，必填。
    smsRequest.set_PhoneNumbers(phone_numbers)

    # 调用短信发送接口，返回json
    smsResponse = acs_client.do_action_with_exception(smsRequest)

    # TODO 业务处理

    return smsResponse

def SendSMS(cellphone,vercode):
    __business_id = uuid.uuid1()
    params = "{'code':\"%s\"}" % vercode
    print(send_sms(__business_id, cellphone, "在线数据采集平台", "SMS_129475602", params))
    


###########################################################
#处理注册函数
#{
#  "code": 0
#  ,"msg": "注册成功"
#  ,"data": {
#    
#  }
#}
def dealReg(request):
    arr = {"code":1,"msg":"你已注册成功，等待审核","data":{}}
    
    if request.method == "POST" and request.POST:
        
        vercode = request.POST['vercode']
        cellphone = request.POST['cellphone']

        if vercode == str(cache.get(cellphone)):
            nickname = request.POST['nickname']
            password = request.POST['password']
            
            filterResult=User.objects.filter(username=nickname)
            if filterResult.exists():
                arr['msg'] = "该用户名称已存在，请重新输入"
            else:
                save = User.objects.create_user(username=nickname,password=password)
                save.profile.phonenumber = cellphone
            
                save.save()
                arr['code'] = 0
                return JsonResponse(arr,safe=False) 
        else:
            arr['msg'] = "验证码不正确，请重新尝试"
            return JsonResponse(arr,safe=False)
    else:
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)
        
    return JsonResponse(arr,safe=False)


#######################################################
# 验证码代码开始
from PIL import (
    Image, ImageDraw, ImageFont, ImageFilter
)
from django.core.cache import cache
from django.conf import settings
from io import BytesIO
import os, random, string, time

class Captcha:
    """
        TODO: 自定义生成图形验证码
        using:  captcha 获取图形验证码
        using: verify_captcha 验证图形验证码
    """

    def __init__(self,t):
        self._code = string.ascii_uppercase + string.digits
        self._width = 130  # 图片宽
        self._height = 38  # 图片高
        self.t = t
        self._bits = 4
        self._draw_line = True  # 干扰线
        self._line_num = (1, 5)  # 干扰线数量
        self._bgcolor = random.randint(0, 255), random.randint(0, 255), random.randint(0, 255)  # 背景颜色
        self._font_path = os.path.join(settings.BASE_DIR, 'captcha/fonts/Vera.ttf')
        self.captcha_code = self._generate_shuffle_str()

    # 生成随机字符串
    def _generate_shuffle_str(self):
        shuffle_list = ','.join(self._code).split(',')
        random.shuffle(shuffle_list)
        return ''.join(shuffle_list[:self._bits])

    # 生成图像
    def _generate_image(self):
        image = Image.new('RGB', (self._width, self._height), self._bgcolor)  # 画布
        font = ImageFont.truetype(self._font_path, 24)  # 用到的字体
        draw = ImageDraw.Draw(image)  # 画笔
        text = self.captcha_code

        # 在画布上画字着色
        for i in range(len(text)):
            font_width, font_height = font.getsize(text[i])
            draw.text((self._width / self._bits * (i + 1) - font_width,
                       (self._height - font_height) / random.randint(2, self._bits)),
                      text[i],
                      font=font, fill=(random.randint(0, 255), random.randint(0, 255), random.randint(0, 255)))

        # 画上干扰线
        if self._draw_line:
            self._append_line(draw)
        # 画上躁点
        self._append_points(draw)
        # 应用图形变换
        image = image.transform((self._width, self._height),
                                Image.AFFINE,
                                (1, 0, 0, 0, 1, 0),
                                Image.BILINEAR)  # 创建扭曲
        image = image.filter(ImageFilter.EDGE_ENHANCE_MORE)  # 汉斯滤镜， 边界加强

        return image

    # 追加躁点
    def _append_points(self, draw):
        chance = min(100, max(0, 5))
        for w in range(self._width):
            for h in range(self._height):
                tmp = random.randint(0, 100)
                if tmp > 100 - chance:
                    draw.point((w, h), fill=(0, 0, 0))

    # 追加干扰线
    def _append_line(self, draw):
        for _ in range(random.randint(*self._line_num)):
            begin = random.randint(0, self._width), random.randint(0, self._height)
            end = random.randint(0, self._width), random.randint(0, self._height)
            draw.line([begin, end], fill=(random.randint(0, 255), random.randint(0, 255), random.randint(0, 255)))

    def captcha(self):
        buf = BytesIO()
        im = self._generate_image()
        tk = self._cache_captcha()
        im.save(buf, 'JPEG')
        im.close()
        buf.seek(0)
        return tk, buf

    # 临时记录图形验证码
    def _cache_captcha(self):
        timestamp_key = self.t
        cache.set(timestamp_key, self.captcha_code, 300)
        return timestamp_key

    # 验证图形验证码
    def verify_captcha(self, timestamp_key=None, captcha=None):
        if timestamp_key and captcha and captcha == cache.get(timestamp_key):
            # del the cache data
            cache.delete(timestamp_key)
            return True
        return False


####
#
def captcha(request):
    t = request.GET.get('t')
    print(t)
    captcha = Captcha(t)
    print(captcha.captcha_code)
    tk, im_buf = captcha.captcha()
    request.session['VerCodeKey']=captcha.captcha_code
    print(request.session['VerCodeKey'])               
    return HttpResponse(im_buf, content_type='image/jpeg')

#    return JsonResponse({'recode': 1,
#                         'remsg': '获取成功！',
#                         'data': {'timestamp': tk, 'captcha': b64encode(im_buf.read()).decode('utf-8')}})

## 验证码代码结束
    
################################################################################
#手机验证码处理函数
#{
#  "code": 0
#  ,"msg": "验证码已成功发送，请注意查收"
#  ,"data": {
#    
#  }
#}
@login_required 
def getPhoneSendVercode(request):
    arr = {"code":0,"msg":"验证码已成功发送，请注意查收","data":{}}
    if request.method == "POST" and request.POST:
        phone = request.POST['phone']
        vercode = int(random.uniform(1,10)*100000)
        
        cache.set(phone, vercode, 300)
        #test
        print(vercode)
        SendSMS(phone,vercode)
    else:
        arr['code'] = 1
        
    return JsonResponse(arr,safe=False)

########################################################


def sensorDataView(request):
    return render(request,'bearing/views/sensorData/sensorDataView.html')

def sensorLiveData(request):
    return render(request,'bearing/views/sensorData/sensorLiveData.html')




def getSensorData(request):
    sensorID = request.GET.get('sensorID')
    opCodeID = request.GET.get('runtime')
    arr = []
    eacharr = []
    
    if not sensorID is None and not opCodeID is None:
        
        sensor = sensorInfo.objects.get(sensorID=sensorID)        
        opStartEnd = opStartEnddate.objects.get(opCodeID=opCodeID)
        sensor_raw_data = sensorRawData.objects.filter(Q(sensorInfo = sensor) & Q(opStartEnddate=opStartEnd)).order_by("saveDate")
        
        for info in sensor_raw_data:
            
            eacharr.append((time.mktime(time.strptime(info.saveDate.strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
            eacharr.append(info.sesorValue)
            
            arr.append(eacharr)
            eacharr = []
    else:
        arr = []
    return JsonResponse(arr,safe=False)  



def getCpuInfo_filter(request):
    
    date_from  = request.GET.get('StartDate')
    date_to = request.GET.get('EndDate')
    arr = []
    eacharr = []
    
    if  date_from is None and  date_to is None:
        ALLcpuinfo = cpuInfo.objects.all()
        for cpuinfo in ALLcpuinfo:
            eacharr.append((time.mktime(time.strptime(cpuinfo.time.strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
            eacharr.append(cpuinfo.value)
            arr.append(eacharr)
            eacharr = []
    else:
        FilterCpuInfo = cpuInfo.objects.filter(time__range=(date_from,date_to))
        for cpuinfo in FilterCpuInfo:
            eacharr.append((time.mktime(time.strptime(cpuinfo.time.strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
            eacharr.append(cpuinfo.value)
            arr.append(eacharr)
            eacharr = []
    return JsonResponse(arr,safe=False)    
        



#接受从数据采集节点传送过来的数据，并保存到数据库中
def saveInfo(request):
    """
        这个方法就是我们的接口方法，
        当被请求时会将请求上来的数据存入数据库
    """
    statue = {}
    log_file = open("message.log", "a")
    
    #重定向标准输入输出
    sys.stdout = log_file
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST: 
        #request.POST 这个方法以字典的形式存放着当前post请求的所有数据
        
        CpuState = request.POST['CpuState']

        MemPercent = request.POST['MemPercent']
        MemUsed = request.POST['MemUsed']
        MemTotal = request.POST['MemTotal']
        
        #获取当前时间
        times = datetime.datetime.now() 
        print('CpuState(%):' + str(CpuState) + ' %\n' 
              + 'MemPercent(%):' + str(MemPercent) +' %\n' 
                           + 'MemUsed(MB):' + str(MemUsed) +' MB\n' 
                                     + 'MemTotal(MB):'+ str(MemTotal) +' MB\n')
        
        if not CpuState is None:
            CpuInfo = cpuInfo(value = float(CpuState),time = times)
            CpuInfo.save()
        if not MemPercent is None and not MemUsed is None:
            MemInfo = memoryInfo(valueUsed = float(MemUsed), memPercent = float(MemPercent), time = times)
            MemInfo.save()
        #定义当前接口状态为保存成功
        statue["statue"] = "request receive success" 
    else:
        #定义当前接口状态为失败
        statue["statue"] = "request method must be post" 
        print('fail')
     #将接口状态返回给请求者
    return JsonResponse(statue)

        
################################################################################        
# 样式动态设置
#导航栏
#arr = {"code":200,"msg":"成功!","data":{}}
@login_required 
def getNav(request):
    arr = {"code":200,"msg":"成功!","data":[]}
    if request.method == "POST":
        AllFactoryInfo =  factory.objects.all().values("factorID","factorDes").distinct()
        arr['data']=list(AllFactoryInfo)
    else:
        arr['code'] = 500
        arr['msg'] = '获取失败,请使用POST方法!'
        
    return JsonResponse(arr,safe=False)     

#部门名称下拉框
def getDepart(request):
    arr = {"code":0,"msg":"成功!","data":[]}
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:
        factorID = request.POST['factoryID']
        if not factorID is None :
            factor = factory.objects.get(factorID = factorID)
            
            AllDepart =  productDepart.objects.filter(factory=factor).values("departID","depatrDes").distinct()
            arr['data'] = list(AllDepart)
        else:
            arr['code'] = 1
            arr['msg'] = '参数错误!'
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 1
        arr['msg'] = '错误，请求方式务必为POST!'
        return JsonResponse(arr,safe=False)


#机床名称下拉框
def getMachine(request):
    arr = {"code":0,"msg":"成功!","data":[]}
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:
        departID = request.POST['departID']
        if not departID is None :
            depart = productDepart.objects.get(departID = departID)
            
            AllMachine =  machine.objects.filter(productDepart=depart ).values("machineID","machineDes").distinct()
            arr['data'] = list(AllMachine)
        else:
            arr['code'] = 1
            arr['msg'] = '参数错误!'
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 1
        arr['msg'] = '错误，请求方式务必为POST!'
        return JsonResponse(arr,safe=False)
    
    
#传感器下拉框
def getSensor(request):
    arr = {"code":0,"msg":"成功!","data":{}}
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:

        machineID = request.POST['machineID']
        
        if not machineID is None :
            machin = machine.objects.get(machineID = machineID)
            
            AllSensor =  sensorInfo.objects.filter(machine=machin).values("sensorID","dsensorDes").distinct()

            arr['data']=list(AllSensor)
        else:
            arr['code'] = 1
            arr['msg'] = '参数错误!'
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 1
        arr['msg'] = '错误，请求方式务必为POST!'
        return JsonResponse(arr,safe=False)
 
#获取机器的运行时间段
def getMachineRunTime(request):
    arr = {"code":0,"msg":"成功!","data":{}}
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:

        machineID = request.POST['machineID']
        
        if not machineID is None :
            dat = []
            machin = machine.objects.get(machineID = machineID)
            
            AllRunTime =  machineRunTime.objects.filter(machine=machin).distinct()
            for RunTime in AllRunTime:
                dat.append({'opCodeID':RunTime.opStartEnddate.opCodeID,'opCodeDes':str(RunTime.opStartEnddate)})
            arr['data']=dat
        else:
            arr['code'] = 1
            arr['msg'] = '参数错误!'
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 1
        arr['msg'] = '错误，请求方式务必为POST!'
        return JsonResponse(arr,safe=False)
    
#通过机器ID来获取机器的运行时间段
def getOpcodeByMachineID(request):
    
    arr = []
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:

        machineID = request.POST['machineID']
        location = request.POST['location']
        
        machineData = sensorInfo.objects.all().filter(location=location)
        machineID = machineData.filter(machineID=machineID)
        for machine in machineID:
    
            info = opStartEnddate.objects.prefetch_related().filter(sensorID=machine)
            for inff in info:
                arr.append(inff.opCodeID)
        return JsonResponse(arr,safe=False)
    else:
        statue = '404'
        return JsonResponse(statue,safe=False)
    
    
    
#获取数据分析中的日期
def getSensorDate(request):
    arr = {"code":0,"msg":"成功!","data":[]}
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:
        date = request.POST['date']
        if not date is None :
            if date == "year":
                select = {'year':'year(saveDate)'}
                allinfo = TemHumConData.objects.extra(select=select).values('year').distinct()
                alldate = []
                
                for info in allinfo:
                    alldate.append({'id':str(info['year']),'date':str(info['year'])})
                
                allinfo = alldate
    
            elif date == "month":
                select = {'year':'year(saveDate)','month':'month(saveDate)'}
                allinfo = TemHumConData.objects.extra(select=select).values('year','month').distinct()
                
                alldate = []
                
                for info in allinfo:
                    alldate.append({'id':str(info['year'])+'-'+str(info['month']),'date':str(info['year'])+'-'+str(info['month'])})
                
                allinfo = alldate
                
            elif date == "day":
                pass
                    
            arr['data'] = list(allinfo)

        else:
            arr['code'] = 1
            arr['msg'] = '参数错误!'
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 1
        arr['msg'] = '错误，请求方式务必为POST!'
        return JsonResponse(arr,safe=False)
    
    
#获取温湿度最大最小值
import calendar
def getMinMaxData(request):
    arr = {"code":0,"msg":"成功!","data":{'date':[],'TemVal':{'min':[],'max':[]},'HumVal':{'min':[],'max':[]}}}

    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:
        date = request.POST['date']
        if not date is None :
            if len(date) == 4:
                arr['data']['TemVal'] = {'min':[0,0,0,0,0,0,0,0,0,0,0,0],'max':[0,0,0,0,0,0,0,0,0,0,0,0]}
                arr['data']['HumVal'] = {'min':[0,0,0,0,0,0,0,0,0,0,0,0],'max':[0,0,0,0,0,0,0,0,0,0,0,0]}
                arr['data']['date'] = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
                allinfo = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)'}).values('year','month').annotate(TemMax=Max('TemValue'),HumMax=Max('HumValue'),TemMin=Min('TemValue'),HumMin=Min('HumValue')).filter(saveDate__year=date)
                for info in allinfo:
                    arr['data']['TemVal']['min'][info['month']-1] = info['TemMin']
                    arr['data']['TemVal']['max'][info['month']-1] = info['TemMax']
                    arr['data']['HumVal']['min'][info['month']-1] = info['HumMin']
                    arr['data']['HumVal']['max'][info['month']-1] = info['HumMax']
    
            elif len(date) >=6 and len(date) <= 7:
                year,month = date.split('-')
                year = int(year)
                month = int(month)
                allinfo = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)','day':'day(saveDate)'}).values('year','month','day').annotate(TemMax=Max('TemValue'),TemMin=Min('TemValue'),HumMax=Max('HumValue'),HumMin=Min('HumValue')).filter(Q(saveDate__year=year) & Q(saveDate__month=month))
                
                for i in range(calendar.monthrange(year, month)[1]+1)[1:]:
                    arr['data']['date'].append(str(i)+'号')
                    arr['data']['TemVal']['min'].append(0)
                    arr['data']['TemVal']['max'].append(0)
                    arr['data']['HumVal']['min'].append(0)
                    arr['data']['HumVal']['max'].append(0)
                    
                for info in allinfo:
                    arr['data']['TemVal']['min'][info['day']-1] = info['TemMin']
                    arr['data']['TemVal']['max'][info['day']-1] = info['TemMax']
                    arr['data']['HumVal']['min'][info['day']-1] = info['HumMin']
                    arr['data']['HumVal']['max'][info['day']-1] = info['HumMax']
            #print(arr)
        else:
            arr['code'] = 1
            arr['msg'] = '参数错误!'
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 1
        arr['msg'] = '错误，请求方式务必为POST!'
        return JsonResponse(arr,safe=False)
    

##############################################################
#小波去噪函数
import pywt
import numpy as np
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
   # plt.show()
    return y

# Test getData
def getRawData(sensor_id,opcode_id):
    sensorID = sensor_id
    opCodeID = opcode_id
    eacharr = []
    
    #Q(sensorInfo = sensor) & Q(opStartEnddate=opStartEnd)
    
    sensor = sensorInfo.objects.get(sensorID=sensorID)
    opStartEnd = opStartEnddate.objects.get(opCodeID=opCodeID)
    
    if not sensor_id is None and not opcode_id is None:
        sensor_raw_data = sensorRawData.objects.filter(Q(sensorInfo = sensor) & Q(opStartEnddate=opStartEnd)).order_by("saveDate")
        for info in sensor_raw_data:
            eacharr.append(info.sesorValue)
    else:
        eacharr = []
    return eacharr

#返回小波去噪处理后的数据
def dealWaveletData(request):
    
    opcode_id = request.GET.get('runtime')
    sensor_id = request.GET.get('sensor_id')
    
    if not opcode_id is None and not sensor_id is None:
        data = getRawData(sensor_id,opcode_id)
        WaveletData = waveletSmooth(data)
        arr = []
        arr.append(data)
        cache.set( str(sensor_id) +'-' + str(opcode_id) , WaveletData.tolist() ,timeout=3000)
        arr.append(WaveletData.tolist())
        return JsonResponse(arr,safe=False)
    else:
        arr = []
        return JsonResponse(arr,safe=False)

    
################################################################
#文件导出函数:将去燥后的数据导出至csv文件
import csv
 
def getWaveletDataToCsv(request):
  # Create the HttpResponse object with the appropriate CSV header.
  opcode_id = request.GET.get('runtime')
  sensor_id = request.GET.get('sensor_id')
  datas = cache.get(str(sensor_id) +'-' + str(opcode_id))
  print(datas)
  response = HttpResponse(content_type='text/csv')

  response['Content-Disposition'] = 'attachment; filename=WaveletData' + str(opcode_id) + '-' + str(sensor_id)
 
  # Create the CSV writer using the HttpResponse as the "file."
  writer = csv.writer(response)
  writer.writerow(['WaveletData'])
  for data in datas:  
      writer.writerow([str(data)])
 
  return response


##################################################################



##################################################################
#
import json
from django.core.cache import cache

from django.core.mail import send_mail
 

@require_websocket
def recTemHumSmogSocket(request):
    Info = None
    RaspId = 'rs01'
    try:
        cache.set(RaspId+':Live1', 1,timeout=None)
        while True:
            message = request.websocket.wait()   
            if not message is None:
                Info = json.loads(message)
    
            #RaspId = Info.id
            #print(message)
            if not Info is None:
                for key,value in Info.items():
                    cache.set( RaspId+':'+key , json.dumps(value),timeout=None)
                save = TemHumConData.objects.create(TemValue= Info['temperature'],HumValue=Info['humidity'], ConValue=Info['concentration'])
                save.save()
    except:
        cache.set(RaspId+':Live1', 0,timeout=None)
 
    
@require_websocket
def recRaspInfoSocket(request):
    Info = None
    RaspId = 'rs01'
    try:
        cache.set(RaspId+':Live2', 1,timeout=None)
        while True:
            message = request.websocket.wait()
            
            if not message is None:
                Info = json.loads(message)
            #RaspId = Info.id
            
            if not Info is None:
                for key,value in Info.items():
                    cache.set(RaspId+':'+key, json.dumps(value),timeout=None)
    except:
        cache.set(RaspId+':Live2', 0,timeout=None)

       
@require_websocket
def sentTemHumSmogSocket(request):
    
    #message = request.websocket.wait()
    #RaspId = message
    key = ['humidity','temperature','concentration','datetime']
    
    data = {}
    RaspId = 'rs01'
    live = cache.get(RaspId+':Live1')
    if live ==1:
        while True:
            for i in range(len(key)):    
                data[key[i]]=json.loads(cache.get(RaspId+':'+key[i]))
            
            message = str(json.dumps(data)).encode(encoding="utf-8")
            request.websocket.send(message)
            time.sleep(1)
    else:
        pass

@require_websocket
def sentRaspInfoSocket(request):
    #rec the id code
    #message = request.websocket.wait()
    #RaspId = message
    key = ['datetime','user','IP','cpuInfo','MemoryInfo','IOInfo','HardDiskInfo','OsVer']
    data = {}
    RaspId = 'rs01'
    live = cache.get(RaspId+':Live2')
    if live ==1:
        while True:
            for i in range(len(key)):    
                data[key[i]]=json.loads(cache.get(RaspId+':'+key[i]))
            
            message = str(json.dumps(data)).encode(encoding="utf-8")
            request.websocket.send(message)
            time.sleep(1)
    else:
        pass
##############################################################
# DATA API

# SEND BACK RASP INFO DATA
#
# {"code":0,"msg":"","count":1000,"data":[
# {"id":10000,"username":"user-0","sex":"女","city":"城市-0","sign":"签名-0","experience":255,"logins":24,"wealth":82830700,"classify":"作家","score":57} 
#]}

def getRaspInfo(request):
    
    arr = {"code":0,"msg":"","count":0,"data":[]}
    
    page = request.GET['page']
    limit = request.GET['limit']
    
  
    Depart = RaspbianInfo.objects.all()
    arr['count'] = len(Depart)
    for info in Depart[(int(page)-1)*int(limit):int(page)*int(limit)]:
        arr['data'].append({"RaspID":info.RaspID,"RaspDes":info.RaspDes,"location":info.location,"saveDate":info.saveDate,"productDepart":info.productDepart.depatrDes,"factory":info.productDepart.factory.factorDes})
    
    return JsonResponse(arr,safe=False)


# ADD A RASP INFO
# 

def addRaspInfo(request):
    arr = {"code":200,"msg":"上位机信息添加成功！","data":{}}
    
    if request.method == "POST" and request.POST:

        RaspID = request.POST['RaspID']
        RaspDes = request.POST['RaspDes']
        location = request.POST['location']
        DepartID = request.POST['productDepart']
        
        
        Depart = productDepart.objects.get(departID=DepartID)
        
        
        info = RaspbianInfo.objects.create(RaspID=RaspID,RaspDes=RaspDes,location=location,productDepart=Depart)
        info.save()
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)
    
    
    
# DEL A RASP INFO
# 
def delRaspInfo(request):
    arr = {"code":200,"msg":"上位机删除成功！","data":{}}
    
    if request.method == "POST" and request.POST:

        RaspID = request.POST['RaspID']
        
        try:
            
            RaspbianInfo.objects.filter(RaspID=RaspID).delete()
        except:
            arr['code'] = 500
            arr['msg'] = "删除出错！"
            return JsonResponse(arr,safe=False)
        
        else:    
            return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)

    
# Get last ID IN RaspInfo

def getLastIDInRaspInfo(request):
    arr = {"code":200,"msg":"获取编号成功！","data":{}}
    if request.method == "POST":
        ID = 0
        info = RaspbianInfo.objects.last()
        if info is None:
            ID = 1
        else:
            ID = info.RaspID + 1
            
        arr['data']['ID'] = ID
        print(ID)
           
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)
    
    
# SEND BACK FACTORY INFO DATA
#
# {"code":0,"msg":"","count":1000,"data":[
# {} 
#]}

def getFactoryInfo(request):
    
    arr = {"code":0,"msg":"","count":0,"data":[]}
    
    page = request.GET['page']
    limit = request.GET['limit']
    
  
    Allinfo = factory.objects.all()
    arr['count'] = len(Allinfo)
    for info in Allinfo[(int(page)-1)*int(limit):int(page)*int(limit)]:
        arr['data'].append({"factorID":info.factorID,"factorDes":info.factorDes,"location":info.location,"personInCharge":info.personInCharge,"saveDate":info.saveDate,"phoneNumber":info.phoneNumber})
    
    return JsonResponse(arr,safe=False)    


# ADD A Factory INFO
# 

def addFactoryInfo(request):
    arr = {"code":200,"msg":"上位机信息添加成功！","data":{}}
    
    if request.method == "POST" and request.POST:

        factorID = request.POST['factorID']
        factorDes = request.POST['factorDes']
        location = request.POST['location']
        personInCharge = request.POST['personInCharge']
        phoneNumber = request.POST['phoneNumber']
        otherInfo = request.POST['otherInfo']
        
        
        info = factory.objects.create(factorID=factorID,factorDes=factorDes,location=location,personInCharge=personInCharge,phoneNumber=phoneNumber,otherInfo=otherInfo)
        info.save()
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)

# DEL A Factory INFO

def delFactoryInfo(request):
    arr = {"code":200,"msg":"上位机删除成功！","data":{}}
    
    if request.method == "POST" and request.POST:

        factorID = request.POST['factorID']
        
        try:
            
            factory.objects.filter(factorID=factorID).delete()
        except:
            arr['code'] = 500
            arr['msg'] = "删除出错！"
            return JsonResponse(arr,safe=False)
        
        else:    
            return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)
    


# Get last ID IN FactoryInfo

def getLastIDInFactoryInfo(request):
    arr = {"code":200,"msg":"获取编号成功！","data":{}}
    if request.method == "POST":
        ID = 0
        info = factory.objects.last()
        if info is None:
            ID = 1
        else:
            ID = info.factorID + 1
            
        arr['data']['ID'] = ID
        print(ID)
           
        return JsonResponse(arr,safe=False)
    else:
        arr['code'] = 500
        arr['msg'] = "请求方式错误，需POST方法"
        return JsonResponse(arr,safe=False)


# SEND BACK Sensor INFO DATA
#
# {"code":0,"msg":"","count":1000,"data":[
# {} 
#]}

def getSensorInfo(request):
    
    arr = {"code":0,"msg":"","count":0,"data":[]}
    
    page = request.GET['page']
    limit = request.GET['limit']
    
  
    Allinfo = Sensor.objects.all()
    arr['count'] = len(Allinfo)
    for info in Allinfo[(int(page)-1)*int(limit):int(page)*int(limit)]:
        arr['data'].append({"SensorDes":info.SensorDes,"SensorType":info.get_SensorType_display(),"SensorKey":info.SensorKey,"otherInfo":info.otherInfo,"saveDate":info.saveDate,"productDepart":info.productDepart.__str__()})
    
    return JsonResponse(arr,safe=False)    


# Get ALL Sensor history DATA

# ({"pointStart":1230764400000,"pointInterval":3600000,"dataLength":0,"data":[]})
# pointStart 开始时间
# piontInterval 间隔时间
# dataLength 数据长度
# data

def gen_dates(b_date, days):
    day = datetime.timedelta(days=1)
    for i in range(days):
        yield b_date + day*i

def get_date_list(start=None, end=None):
    """
    获取日期列表
    :param start: 开始日期
    :param end: 结束日期
    :return:
    """
    if start is None:
        start = datetime.datetime.strptime("2000-01-01", "%Y-%m-%d")
    if end is None:
        end = datetime.datetime.now() + datetime.timedelta(days=2)
    data = []
    for d in gen_dates(start, (end-start).days):
        data.append(d)
    #print(data)
    #print(datetime.datetime.now())
    return data


def getSensorHisData(request):
    starttime = datetime.datetime.now()
    arr = ({"pointStart":0,"pointInterval":3600000,"dataLength":0,"data":{'Tem':[],'Hum':[],'Con':[]}})
    
    Allinfo = TemHumConData.objects.all()
    allinfo = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)','day':'day(saveDate)','hour':'hour(saveDate)'}).values('year','month','day','hour').annotate(TemAvg=Avg('TemValue'),HumAvg=Avg('HumValue'),ConAvg=Avg('ConValue'))
    
    Tem = []
    Hum = []
    Con = []
    TemDate = []
    
    for info in allinfo:
        TemDate.append({'date':str(info['year'])+'-'+str(info['month'])+'-'+str(info['day'])+' '+str(info['hour']),'TemAvg':round(info['TemAvg'],2),'HumAvg':round(info['HumAvg'],2),'ConAvg':round(info['ConAvg'],2)})
            
    if Allinfo.exists() and allinfo.exists():
        startDate = ((Allinfo[0].saveDate.replace(minute=0, second=0, microsecond=0)))
        arr['pointStart'] = (int((Allinfo[0].saveDate.replace(minute=0, second=0, microsecond=0) +datetime.timedelta(hours=8) ).timestamp())*1000)
        fisrtHour = int(Allinfo[0].saveDate.strftime("%H"))
        
        days = get_date_list(start=startDate)
        #print(days)
        #list_iterator
        TemDate_iter = iter(TemDate)
        begin = TemDate_iter.__next__()

        for day in days:

            if day.strftime("%Y-%-m-%-d") == begin['date'].split(" ")[0]:
                
                for i in [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0]:
                    
                    if i == int(begin['date'].split(" ")[1]):
                        Tem.append(begin['TemAvg'])
                        Hum.append(begin['HumAvg'])
                        Con.append(begin['ConAvg'])
                        try:
                            begin = TemDate_iter.__next__()
                        except StopIteration:
                            pass
                    else:
                        Tem.append(None)
                        Hum.append(None)
                        Con.append(None)
                        
            else:
                Tem += [None]*24
                Hum += [None]*24
                Con += [None]*24       
    endtime = datetime.datetime.now()
    print((endtime - starttime).seconds)
    arr['data']['Tem'] = Tem[fisrtHour-1:]
    arr['data']['Hum'] = Hum[fisrtHour-1:]
    arr['data']['Con'] = Con[fisrtHour-1:]
    
    return JsonResponse(arr,safe=False)

def getEveryMonthData(request):
    arr = {"code":0,"msg":"发送成功！","data":{'date':[],'TemAvg':[0,0,0,0,0,0,0,0,0,0,0,0],'HumAvg':[0,0,0,0,0,0,0,0,0,0,0,0]}}
    date = 2018
    arr['data']['date'] = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
    allinfo = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)'}).values('year','month').annotate(TemAvg=Avg('TemValue'),HumAvg=Avg('HumValue')).filter(saveDate__year=date)
    
    for info in allinfo:
        arr['data']['TemAvg'][info['month']-1]=(round(info['TemAvg'],2))
        arr['data']['HumAvg'][info['month']-1]=(round(info['HumAvg'],2))
        
    return JsonResponse(arr,safe=False)



def getPersentData(request):
    arr = {"code":0,"msg":"发送成功！","data":{"Tem":[['极高温', 0],['高温', 0],{'name': '舒适','y': 0,'sliced': 'true','selected': 'true' },['寒冷', 0]],"Hum":[['潮湿', 0],{'name': '舒适','y': 0,'sliced': 'true','selected': 'true' },['干燥', 0]]}}
    TemHigh, TemFix, TemLow = 35,28,10
    HumHigh, HumFix = 40,30

    date = 2018
    allinfo = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)','day':'day(saveDate)'}).values('year','month','day').annotate(TemAvg=Avg('TemValue'),HumAvg=Avg('HumValue')).filter(saveDate__year=date)
    
    for info in allinfo:
        if info['TemAvg'] > TemHigh:
            arr['data']['Tem'][0][1]+=1
        elif info['TemAvg'] > TemFix:
            arr['data']['Tem'][1][1]+=1
        elif info['TemAvg'] > TemLow:
            arr['data']['Tem'][2]['y']+=1
        else:
            arr['data']['Tem'][3][1]+=1
        print(info['HumAvg'])       
        if info['HumAvg'] > HumHigh:
            arr['data']['Hum'][0][1]+=1
        elif info['HumAvg'] > HumFix:
            arr['data']['Hum'][1]['y']+=1
        else:
            arr['data']['Hum'][2][1]+=1
        
        
    return JsonResponse(arr,safe=False)
    
def getReport(date = 2018):
    data = {"code":0,"msg":"发送成功！","data":[{'title':'气温分布占比','Content':''},{'title':'湿度分布占比','Content':''},{'title':'','Content':''}]}
    date = 2018
    TemHigh, TemFix, TemLow = 35,28,10
    HumHigh, HumFix = 40,30
    arr = {'Tem':[0,0,0,0],'Hum':[0,0,0]}
    allinfo = TemHumConData.objects.extra(select={'year':'year(saveDate)','month':'month(saveDate)','day':'day(saveDate)'}).values('year','month','day').annotate(TemAvg=Avg('TemValue'),HumAvg=Avg('HumValue')).filter(saveDate__year=date)
    
    for info in allinfo:
        if info['TemAvg'] > TemHigh:
            arr['Tem'][0]+=1
        elif info['TemAvg'] > TemFix:
            arr['Tem'][1]+=1
        elif info['TemAvg'] > TemLow:
            arr['Tem'][2]+=1
        else:
            arr['Tem'][3]+=1
      
        if info['HumAvg'] > HumHigh:
            arr['Hum'][0]+=1
        elif info['HumAvg'] > HumFix:
            arr['Hum'][1]+=1
        else:
            arr['Hum'][2]+=1
     
        
    TemIndex,HumIndex = arr['Tem'].index(max(arr['Tem'])),arr['Hum'].index(max(arr['Hum']))
    
    if TemIndex == 0:
        data['data'][0]['Content']+='极高温天气占比较多，长时间高温能使人体感到不适，工作效率降低，中暑、患肠道疾病和心脑血管等病症的发病率增多。\n需要提醒工人们多喝水。夏季缺水，会使体温太高，容易中暑。\n同时应该加装空调，或降低空调的运行温度，使工人们工作环境更加舒适。'
    elif TemIndex == 1:
        data['data'][0]['Content']+='高温天气占比较多，温度较高能使工人们体感到不适，大大降低了工人们的工作效率。\n需调整空调的运行温度，使工人们工作环境更加舒适。'
    elif TemIndex == 2:
        data['data'][0]['Content']+='舒适程度占比较高。工作环境比较舒适，舒适的温度可以使工人们提高工作效率。\n如果维持这种工作环境，工人满意度会提高，可以留住更多人为我司工作。'
    elif TemIndex == 3:
        data['data'][0]['Content']+='寒冷占比较高，寒冷天气来袭。\n考虑应为加装暖气等制暖措施！'
        
            
    if HumIndex == 0:
        data['data'][1]['Content']+='潮湿环境占比比较高。\n长时间潮湿环境能使人体感到不适，工作效率降低。\n潮湿环境对结核病、肾脏病、风湿性关节炎、慢性腰腿痛等病患者都有不良的影响，影响工人们的身体健康。'
    elif HumIndex == 1:
        data['data'][1]['Content']='舒适程度占比较高。\n工作环境比较舒适，舒适的温度可以使工人们提高工作效率。'
    elif HumIndex == 2:
        data['data'][1]['Content']+='干燥环境占比较高。\n干燥的空气具有一定的危害。首先是易造成细菌的传播。干燥的空气是造成灰尘、悬浮颗粒物飘浮增多的主要原因，而细菌不能单独存在，往往依附于灰尘之上。'
    return data