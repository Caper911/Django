# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-04-11 01:34
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bearing', '0003_auto_20180409_1238'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='opstartenddate',
            name='sensorID',
        ),
        migrations.AlterField(
            model_name='opstartenddate',
            name='endDate',
            field=models.DateTimeField(),
        ),
        migrations.AlterField(
            model_name='opstartenddate',
            name='startDate',
            field=models.DateTimeField(),
        ),
    ]
