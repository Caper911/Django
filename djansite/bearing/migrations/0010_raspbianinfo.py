# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-04-28 13:19
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('bearing', '0009_auto_20180422_0048'),
    ]

    operations = [
        migrations.CreateModel(
            name='RaspbianInfo',
            fields=[
                ('RaspID', models.AutoField(primary_key=True, serialize=False, verbose_name='上位机ID')),
                ('RaspDes', models.CharField(max_length=100, verbose_name='上位机描述')),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('modDate', models.DateTimeField(auto_now=True, verbose_name='最后修改日期')),
                ('location', models.CharField(max_length=20, verbose_name='方位')),
                ('productDepart', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.productDepart')),
            ],
        ),
    ]
