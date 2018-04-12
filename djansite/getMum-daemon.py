import os
import sys
import time
import requests

from daemon import Daemon
import psutil


url = "http://192.168.123.134:8000/api/getmem/"

#继承Daemon类，使目标函数成为守护进程
class getInfoDaemon(Daemon):
    #守护进程中的处理函数
    def run(self):
         while True:
            CpuState = psutil.cpu_percent(None)
            phymem = psutil.virtual_memory()
            MemPercent = phymem.percent
            MemUsed = int(phymem.used/1024/1024)
            MemTotal = int(phymem.total/1024/1024)

    
            data = {"CpuState":CpuState,"MemPercent":MemPercent,"MemUsed":MemUsed,"MemTotal":MemTotal,}
    
            print(data)
#定义请求头部
            header = {
                "User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
            }
    
            res = requests.post(url,data = data,headers = header,)
            status_code = res.status_code
    
            if(status_code == 200):
                print('status code : 200,sucess!')
            else:
                print('status code : '+ str(status_code) + ',sucess!')
            time.sleep(1)

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
