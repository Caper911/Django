# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-03-11 05:13
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bearing', '0002_testinfo_user'),
    ]

    operations = [
        migrations.AlterField(
            model_name='testinfo',
            name='info',
            field=models.CharField(max_length=30),
        ),
    ]
