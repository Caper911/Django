# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-05-07 17:10
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('bearing', '0013_sensor_sensortype'),
    ]

    operations = [
        migrations.AddField(
            model_name='sensor',
            name='productDepart',
            field=models.ForeignKey(default=None, on_delete=django.db.models.deletion.CASCADE, to='bearing.productDepart'),
        ),
        migrations.AlterField(
            model_name='sensor',
            name='SensorType',
            field=models.CharField(choices=[(0, '数值型传感器'), (1, '开关型传感器'), (2, '泛型传感器'), (-1, '请选择类型')], default=-1, max_length=2, verbose_name='传感器类型'),
        ),
    ]