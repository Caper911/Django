#!/usr/bin/env python

from __future__ import print_function
import time
import json
import websocket
from RF24 import *
import RPi.GPIO as GPIO


### 守护进程 库文件
import os
import sys
import time

from daemon import Daemon


##########################################
def try_read_data(radio,webSocketUrl,channel=0):
    # 判断信道是否可用
    if radio.available():
        reconnect = True

        while radio.available():
            len = radio.getDynamicPayloadSize()
            receive_payload = radio.read(len)
            
            #打印数据等信息
            print('时间：'+ time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time())))
            print('接受到数据的长度={} 源数据="{}"'.format(len, receive_payload.decode('utf-8')))
            # 对收到的数据进行截取
            arr = receive_payload.decode('utf-8').split(',')
            print('湿度:' + str(arr[0]) +'%')
            print('温度:' + str(arr[1]) +'℃')
            print('可燃气体浓度:' + str(arr[2]) +'\n')
            # 停止监听
            radio.stopListening()
            
            info= {'id':'rs01','humidity':arr[0],'temperature':arr[1],'concentration':arr[2] }
            
            # 逻辑是 接收一次数据就发送，发送不成功则丢弃本次数据
            try:
                if reconnect:
                    ws = websocket.create_connection(webSocketUrl)
                    print(time.strftime("%Y-%m-%d %H:%M:%S",time.localtime())+':'+"Server Connect Success!")
    
                ws.send(json.dumps(info))

            except:
                print(time.strftime("%Y-%m-%d %H:%M:%S",time.localtime()) +':'+"Server Connect Error!")
                reconnect = True
            # 
            else:
                reconnect = False
  
            # 向发送端发送响应
            radio.write(receive_payload)
            
            # 继续监听数据的到来
            radio.startListening()
        ws.close()


##########################################
def try_read_dataa(radio,channel=0):
    # 判断是否有数据
    if radio.available():
        
        while radio.available():
            len = radio.getDynamicPayloadSize()
            receive_payload = radio.read(len)
            arr = receive_payload.decode('utf-8').split(',')
            # 停止监听
            radio.stopListening()
            
            info= {'id':'rs01','humidity':arr[0],'temperature':arr[1],'concentration':arr[2] }
            
            # 向发送端发送响应
            radio.write(receive_payload)
            
            # 继续监听数据的到来
            radio.startListening()
    
        return info

##########################################
def InitRadio(radio,pipes,inp_role,irq_gpio_pin):
    #初始化程序
    if inp_role == '0':
        print('角色: 接收端, 等待数据传输...')
        if irq_gpio_pin is not None:
            GPIO.setmode(GPIO.BCM)
            GPIO.setup(irq_gpio_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
            GPIO.add_event_detect(irq_gpio_pin, GPIO.FALLING, callback=try_read_data)
        #设置
        # pipes[1] 为发送信道
        # pipes[0] 为接收信道
        radio.openWritingPipe(pipes[1])
        radio.openReadingPipe(1,pipes[0])
        radio.startListening()
    else:
        print('角色: 发送端， 数据发送中...')
        #设置
        # pipes[0] 为发送信道
        # pipes[1] 为接收信道
        radio.openWritingPipe(pipes[0])
        radio.openReadingPipe(1,pipes[1])
    
##########################################
def SendOrRecData(radio,inp_role,irq_gpio_pin,webSocketUrl):
    millis = lambda: int(round(time.time() * 1000))

    # 发送测试数据
    send_payload = b'TEST'

    while 1:
        if inp_role == '1':   # 角色:发送端
            radio.stopListening()
            print('正在发送... 长度为 {} ... '.format(len(send_payload)), end="")
            radio.write(send_payload)

            # 发送完毕后，监听接收端的响应
            radio.startListening()

            # 等待时间
            started_waiting_at = millis()
            timeout = False
            
            while (not radio.available()) and (not timeout):
                if (millis() - started_waiting_at) > 500:
                    timeout = True
            
            if timeout:
                print('接收错误！, 响应时间过长.')
            else:
                len = radio.getDynamicPayloadSize()
                receive_payload = radio.read(len)
                print('接收到响应 长度为{} 数据为"{}"'.format(len, receive_payload.decode('utf-8')))

            time.sleep(1)
        else:
            if irq_gpio_pin is None:
                info = try_read_dataa(radio)
                try:
                    if reconnect:
                        ws = websocket.create_connection(webSocketUrl)
                        print(time.strftime("%Y-%m-%d %H:%M:%S",time.localtime())+':'+"Server Connect Success!")
        
                    ws.send(json.dumps(info))

                except:
                    print(time.strftime("%Y-%m-%d %H:%M:%S",time.localtime()) +':'+"Server Connect Error!")
                    reconnect = True
                # 
                else:
                    reconnect = False

                #等待一秒
                time.sleep(1)
            else:
                time.sleep(1000)

def loopSend():

    radio = RF24(22, 0);
    # 信道
    pipes = [0xE8E8F0F0E1, 0xE8E8F0F0E1]


    irq_gpio_pin = None

    # 设置角色 为接收端
    # 0为发送端 1为接收端
    inp_role = '0'

    

    # 服务器地址
    webSocketUrl = "ws://192.168.123.134:8000/socket/recTemHumSmogSocket"
    
    print('上位机接收数据程序')
    
    # 信道开始
    radio.begin()
    radio.enableDynamicPayloads()
    radio.setRetries(15,15)
    radio.printDetails()

    print(' ************ Role Setup *********** ')
    while (inp_role !='0') and (inp_role !='1'):
        inp_role = str(input('等待数据的到达( CTRL+C 退出) '))

    InitRadio(radio,pipes,inp_role,irq_gpio_pin)
    SendOrRecData(radio,inp_role,irq_gpio_pin,webSocketUrl)
    



#继承Daemon类，使目标函数成为守护进程
class getInfoDaemon(Daemon):
    #守护进程中的处理函数
    def run(self):
        print("=============================================Daemon Start:")
        print("====Time:"+ time.strftime("%Y-%m-%d %H:%M:%S",time.localtime()))
        loopSend()
        
#初始化类,设定错误/日志输出文件
if __name__ == '__main__':
    PIDFILE = '/tmp/daemon-sensorSend.pid'
    ERROR = '/tmp/daemon-sensor-server-error.log'
    LOG = '/tmp/daemon-sensor-server.log'
    
    daemon = getInfoDaemon(pidfile=PIDFILE, stdout=LOG, stderr=ERROR)

    if len(sys.argv) != 2:
        print('Usage: {} [start|stop]'.format(sys.argv[0]), file=sys.stderr)
        raise SystemExit(1)

    if 'start' == sys.argv[1]:
        daemon.start()
    elif 'stop' == sys.argv[1]:
        daemon.stop()
    elif 'restart' == sys.argv[1]:
        daemon.restart()
    else:
        print('Unknown command {!r}'.format(sys.argv[1]), file=sys.stderr)
        raise SystemExit(1)
