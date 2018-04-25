#!/usr/bin/env python



from __future__ import print_function
import time
import json
import websocket
from RF24 import *
import RPi.GPIO as GPIO

irq_gpio_pin = None

########### USER CONFIGURATION ###########
# See https://github.com/TMRh20/RF24/blob/master/pyRF24/readme.md

# CE Pin, CSN Pin, SPI Speed

# Setup for GPIO 22 CE and CE0 CSN with SPI Speed @ 8Mhz
#radio = RF24(RPI_V2_GPIO_P1_15, BCM2835_SPI_CS0, BCM2835_SPI_SPEED_8MHZ)



#RPi B+
# Setup for GPIO 22 CE and CE0 CSN for RPi B+ with SPI Speed @ 8Mhz
#radio = RF24(RPI_BPLUS_GPIO_J8_15, RPI_BPLUS_GPIO_J8_24, BCM2835_SPI_SPEED_8MHZ)

# RPi Alternate, with SPIDEV - Note: Edit RF24/arch/BBB/spi.cpp and  set 'this->device = "/dev/spidev0.0";;' or as listed in /dev
radio = RF24(22, 0);


# Setup for connected IRQ pin, GPIO 24 on RPi B+; uncomment to activate
#irq_gpio_pin = RPI_BPLUS_GPIO_J8_18
#irq_gpio_pin = 24

##########################################
def try_read_data(channel=0):
    if radio.available():
        while radio.available():
            len = radio.getDynamicPayloadSize()
            receive_payload = radio.read(len)
            
            print('时间：'+ time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time())))
            print('接受到数据的长度={} 源数据="{}"'.format(len, receive_payload.decode('utf-8')))
            arr = receive_payload.decode('utf-8').split(',')
            print('湿度:' + str(arr[0]) +'%')
            print('温度:' + str(arr[1]) +'℃')
            print('可燃气体浓度:' + str(arr[2]) +'\n')
            # First, stop listening so we can talk
            radio.stopListening()
                

            info= {'id':'rs01','humidity':arr[0],'temperature':arr[1],'concentration':arr[2] }
       
            
            loop = True

            while loop:
                try:
                    if reconnect:
                        ws = websocket.create_connection(webSocketUrl)
            
                    ws.send(json.dumps(info))
                    reconnect = False
                    loop = False
                except:
                    print("connect error!")
                    reconnect = True
                    loop = True


            ws.send(json.dumps(info))
            
            # Send the final one back.
            radio.write(receive_payload)
            #print('Sent response.')

            # Now, resume listening so we catch the next packets.
            radio.startListening()

pipes = [0xE8E8F0F0E1, 0xE8E8F0F0E1]
min_payload_size = 4
max_payload_size = 32
payload_size_increments_by = 1
next_payload_size = min_payload_size
inp_role = '0'
send_payload = b'ABCDEFGHIJKLMNOPQRSTUVWXYZ789012'
millis = lambda: int(round(time.time() * 1000))
webSocketUrl = "ws://192.168.123.134:8000/socket/sentTemHumSmogSocket"

reconnect = True

print('上位机接收数据程序')
radio.begin()
radio.enableDynamicPayloads()
radio.setRetries(15,15)
radio.printDetails()

print(' ************ Role Setup *********** ')
while (inp_role !='0') and (inp_role !='1'):
    inp_role = str(input('等待数据的到达( CTRL+C 退出) '))

#初始化程序
if inp_role == '0':
    print('Role: Pong Back, awaiting transmission')
    if irq_gpio_pin is not None:
        # set up callback for irq pin
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(irq_gpio_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
        GPIO.add_event_detect(irq_gpio_pin, GPIO.FALLING, callback=try_read_data)

    radio.openWritingPipe(pipes[1])
    radio.openReadingPipe(1,pipes[0])
    radio.startListening()
else:
    print('Role: Ping Out, starting transmission')
    radio.openWritingPipe(pipes[0])
    radio.openReadingPipe(1,pipes[1])

# forever loop
while 1:
    if inp_role == '1':   # ping out
        # The payload will always be the same, what will change is how much of it we send.

        # First, stop listening so we can talk.
        radio.stopListening()

        # Take the time, and send it.  This will block until complete
        print('Now sending length {} ... '.format(next_payload_size), end="")
        radio.write(send_payload[:next_payload_size])

        # Now, continue listening
        radio.startListening()

        # Wait here until we get a response, or timeout
        started_waiting_at = millis()
        timeout = False
        while (not radio.available()) and (not timeout):
            if (millis() - started_waiting_at) > 500:
                timeout = True

        # Describe the results
        if timeout:
            print('failed, response timed out.')
        else:
            # Grab the response, compare, and send to debugging spew
            len = radio.getDynamicPayloadSize()
            receive_payload = radio.read(len)

            # Spew it
            print('got response size={} value="{}"'.format(len, receive_payload.decode('utf-8')))

        # Update size for next time.
        next_payload_size += payload_size_increments_by
        if next_payload_size > max_payload_size:
            next_payload_size = min_payload_size
        time.sleep(0.1)
    else:
        # Pong back role.  Receive each packet, dump it out, and send it back

        # if there is data ready
        if irq_gpio_pin is None:
            # no irq pin is set up -> poll it
            try_read_data()
        else:
            # callback routine set for irq pin takes care for reading -
            # do nothing, just sleeps in order not to burn cpu by looping
            time.sleep(1000)

