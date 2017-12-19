#!/usr/bin/env python
#coding:utf-8

import os
import django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "djansite.settings")
django.setup()

''' 
##版本的判断
import django
if django.VERSION >= (1,7):
    django.setup()
'''
###
#读取文件插入到数据库中

def main():
    f = open('2003.10.22.12.06.24') 
    from bearing.models import locationOne
    for line in f:
        ch1,ch2,ch3,ch4,ch5,ch6,ch7,ch8 = line.split(sep='	')
        locationOne.objects.create(ch1=ch1,ch2=ch2,ch3=ch3,ch4=ch4,ch5=ch5,ch6=ch6,ch7=ch7,ch8=ch8)
        print(ch1,)

        
    f.close()

if __name__ == "__main__":
    main()
    print('Done!')


