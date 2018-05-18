# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-05-07 15:51
from __future__ import unicode_literals

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('bearing', '0011_auto_20180507_0930'),
    ]

    operations = [
        migrations.CreateModel(
            name='Sensor',
            fields=[
                ('SensorID', models.AutoField(primary_key=True, serialize=False, verbose_name='传感器ID')),
                ('SensorDes', models.CharField(max_length=100, verbose_name='传感器描述')),
                ('SensorKey', models.CharField(max_length=64, verbose_name='传感器编号')),
                ('Unit', models.CharField(max_length=20, verbose_name='数值单位')),
                ('otherInfo', models.TextField(blank=True, null=True, verbose_name='备注 ')),
                ('is_active', models.BooleanField(default=False, verbose_name='是否有效')),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('modDate', models.DateTimeField(auto_now=True, verbose_name='最后修改日期')),
            ],
            options={
                'verbose_name': '传感器信息',
                'verbose_name_plural': '传感器信息',
            },
        ),
        migrations.AlterModelOptions(
            name='version',
            options={'ordering': ['-saveDate'], 'verbose_name': '版本更新信息', 'verbose_name_plural': '版本更新信息'},
        ),
    ]