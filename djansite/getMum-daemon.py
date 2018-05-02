import os
import sys
import time

from daemon import Daemon
import psutil
import getpass
import json
import websocket


webSocketUrl = "ws://192.168.123.134:8000/socket/recRaspInfoSocket"

def sentRspiData(webSocketUrl):
    reconnect = True

    while True:
        try:
            if reconnect:
                ws = websocket.create_connection(webSocketUrl)
            
            rspiInfo = rspi()
            info= {'datetime':time.strftime("%Y-%m-%d %H:%M:%S",time.localtime()),'id':'rs01','user':rspiInfo.USER,'IP':rspiInfo.IP,'OsVer':rspiInfo.getOsVersion(),'cpuInfo':rspiInfo.CpuInfo(),
                 'MemoryInfo':rspiInfo.MemoryInfo(),'IOInfo':rspiInfo.IOInfo(), 'HardDiskInfo':rspiInfo.HardDiskInfo() }

            ws.send(json.dumps(info))
            print(ws)
            info['datetime'] =''
            reconnect = False
        except:
            print("connect error!")
            reconnect = True
            
    ws.close()
            
    
class rspi:
    USER = getpass.getuser()
    IP = psutil.net_if_addrs()['wlp8s0'][0][1]
    
    def getOsVersion(self):
        with open('/etc/issue') as fd:
            for line in fd:
                osver = line.strip()
                break
        return osver[:-6]

    def CpuInfo(self):
        cpuNum = psutil.cpu_count()
        cpuPercent = psutil.cpu_percent(None)
        cpuEachPercent = psutil.cpu_percent(percpu = True)
        # current -> [1] highest -> [2]
        if len(psutil.sensors_temperatures()) ==0:
            cpuTemperature =99
        else:
            cpuTemperature = psutil.sensors_temperatures()['coretemp'][0]
            
        return {'cpuNum':cpuNum,'cpuPercent':cpuPercent,
                'cpuEachPercent':cpuEachPercent,'cpuTemperature':cpuTemperature}
        
    def MemoryInfo(self):
        #virtual_memory
        virtual_memory = psutil.virtual_memory()
        virtual_total = virtual_memory[0] 
        virtual_available = virtual_memory[1] 
        virtual_percent = virtual_memory[2] 
        virtual_used = virtual_memory[3] 
        virtual_free = virtual_memory[4] 
        virtual_active = virtual_memory[5] 
        virtual_inactive = virtual_memory[6] 
        virtual_buffers = virtual_memory[7] 
        virtual_cached = virtual_memory[8] 
        virtual_shared = virtual_memory[9] 
        #swap_memory
        swap_memory = psutil.swap_memory()
        swap_total = swap_memory[0]
        swap_used = swap_memory[1]
        swap_free = swap_memory[2]
        swap_percent = swap_memory[3]
        
        return {'virtual_memory':virtual_memory,'swap_memory':swap_memory}
        
    def IOInfo(self):
        net_io_counters = psutil.net_io_counters(pernic=True)['wlp8s0']
        sent = net_io_counters[0]
        recv = net_io_counters[1] 
        time.sleep(1)
        net_io_counters = psutil.net_io_counters(pernic=True)['wlp8s0']
        sent_1s = net_io_counters[0]
        recv_1s = net_io_counters[1]
        
        IO_sent_speed = sent_1s - sent
        IO_recv_speed = recv_1s - recv
        
        bytes_sent = psutil.net_io_counters()[0]
        bytes_recv = psutil.net_io_counters()[1]
                                           
        return {'bytes_sent':bytes_sent,'IO_sent_speed':IO_sent_speed,
                'bytes_recv':bytes_recv,'IO_recv_speed':IO_recv_speed}           
        
    def HardDiskInfo(self):
        
        disk_total = psutil.disk_usage('/')[0]
        disk_used = psutil.disk_usage('/')[1]
        disk_free = psutil.disk_usage('/')[2]
        disk_percent = psutil.disk_usage('/')[3]
    
        return {'disk_total':disk_total,'disk_used':disk_used,
                'disk_free':disk_free,'disk_percent':disk_percent} 

#继承Daemon类，使目标函数成为守护进程
class getInfoDaemon(Daemon):
    #守护进程中的处理函数
    def run(self):
         sentRspiData(webSocketUrl)

#初始化类,设定错误/日志输出文件
if __name__ == '__main__':
    PIDFILE = '/tmp/daemon-getserver.pid'
    ERROR = '/tmp/daemon-server-error.log'
    LOG = '/tmp/daemon-server.log'
    
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
