from django.shortcuts import render
from bearing.models import cpuInfo,memoryInfo,ioInfo
from bearing.models import sensorInfo,opStartEnddate,sensorData
from django.contrib.auth import authenticate,login,logout
from django.contrib import auth
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
import json
import sys
import datetime
import time
import random


# Create your views here.
#@login_required 
def index(request):
    return render(request,'bearing/views/index.html')

def home(request):
    return render(request,'bearing/views/home/console.html')

def login(request):
    return render(request,'bearing/user/login.html')

def logout_view(request):

    arr = {"code": 0,"msg": "退出成功","data": {}}
    if 'username' in request.session:    
        del request.session['username']
        
    logout(request)

    return JsonResponse(arr,safe=False)

def register(request):
    return render(request,'bearing/user/reg.html')

def componentGridAll(request):
    return render(request,'bearing/views/component/grid/all.html')

def setUserInfo(request):
    return render(request,'bearing/views/set/user/info.html')

def setUserPassword(request):
    return render(request,'bearing/views/set/user/password.html')

def setSystemWebsite(request):
    return render(request,'bearing/views/set/system/website.html')

def setSystemEmail(request):
    return render(request,'bearing/views/set/system/email.html')

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


#######################################################
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
        image = Image.new('RGBA', (self._width, self._height), self._bgcolor)  # 画布
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


################################################################################
#手机验证码处理函数
#{
#  "code": 0
#  ,"msg": "验证码已成功发送，请注意查收"
#  ,"data": {
#    
#  }
#}
def getPhoneSendVercode(request):
    arr = {"code":0,"msg":"验证码已成功发送，请注意查收","data":{}}
    if request.method == "POST" and request.POST:
        phone = request.POST['phone']
        vercode = int(random.uniform(1,10)*100000)
        
        cache.set(phone, vercode, 300)
        #test
        print(vercode)
        #SendSMS(phone,vercode)
    else:
        arr['code'] = 1
        
    return JsonResponse(arr,safe=False)

########################################################


def adminindex(request):
    return render(request,'bearing/admin-index.html')

def sensorDataView(request):
    return render(request,'bearing/sensorDataView.html')



#返回测试数据，用于增加图表的数据点
def ajax_dict(request):
    ## back type is QuerySet
    arr = []
    
    #allch = locationOne.objects.all()
    allinfo = testInfo.objects.all()
    for info in allinfo:
        arr.append(info.num)
    
    return JsonResponse(arr,safe=False)

#
def get_last_info(info):
    arr = {}
    
    if(info == 'cpu'):
        cpuinfo = cpuInfo.objects.last()
        if not cpuinfo is None:    
            arr = {'value':cpuinfo.value,'time':str(cpuinfo.time.strftime("%Y/%m/%d %H:%M:%S"))}   
        else:
            arr = {}
    elif(info == 'mem'):
        meminfo = memoryInfo.objects.last()
        if not meminfo is None:    
            arr = {'valueUsed':meminfo.valueUsed,'memPercent':meminfo.memPercent,'time':str(meminfo.time.strftime("%Y/%m/%d %H:%M:%S"))}
        else:
            arr = {}
        
    return arr
    

def getlast19_info(request):
    
    infolist = []
    allinfo = cpuInfo.objects.order_by('-id')
    arr = allinfo[1:21]
    for arrinfo in arr:
        infolist.append(arrinfo.value)
        
    infolist.reverse()
    return JsonResponse(infolist,safe=False)


def getSensorInfo(request):
    sensor_id = request.GET.get('opCodeID')
    sensor_name = request.GET.get('sensorName')
    arr = []
    eacharr = []
    if not sensor_id is None and not sensor_name is None:
        sensor_info = sensorData.objects.values(sensor_name,'time').filter(opCodeID=sensor_id)
        for info in sensor_info:
            eacharr.append((time.mktime(time.strptime(info['time'].strftime("%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S")))*1000)
            eacharr.append(info[sensor_name])
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
        
#ajax向服务器发出post请求，返回数据给ajax
def ajax_dict_realtime(request):
    
    info = request.GET.get('info')
    lastInfo = get_last_info(info)

    return JsonResponse(lastInfo,safe=False) #将接口状态返回给请求者

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
#下拉框
def getMachineIDbylocation(request):
    statue = ""
    #检测请求的方式是post，并且post请求有数据
    if request.method == "POST" and request.POST:
        location = request.POST['location']
        arr = []
        if not location is None:    
            AllMachineID =  sensorInfo.objects.filter(location=location ).values("machineID").distinct()
            for MachineID in AllMachineID:
                arr.append(MachineID)
        else:
            arr = []
        return JsonResponse(arr,safe=False)
    else:
        statue = '404'
        return JsonResponse(statue,safe=False)
    
def getOpcodeByMachineID(request):
    statue = ""
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


        
        
    
    
    
    
