# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-05-07 09:30
from __future__ import unicode_literals

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('bearing', '0010_raspbianinfo'),
    ]

    operations = [
        migrations.CreateModel(
            name='Version',
            fields=[
                ('VersionID', models.AutoField(primary_key=True, serialize=False, verbose_name='版本ID')),
                ('Version', models.CharField(max_length=100, verbose_name='版本号')),
                ('VersionContent', models.TextField(blank=True, null=True, verbose_name='版本更新内容 ')),
                ('UpdatePerson', models.CharField(max_length=12, verbose_name='更新人')),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
            ],
            options={
                'verbose_name': '版本更新信息',
                'verbose_name_plural': '版本更新信息',
            },
        ),
        migrations.AlterModelOptions(
            name='raspbianinfo',
            options={'verbose_name': '上位机信息', 'verbose_name_plural': '上位机信息'},
        ),
        migrations.AlterModelOptions(
            name='temhumcondata',
            options={'verbose_name': '车间环境传感器数据', 'verbose_name_plural': '车间环境传感器数据'},
        ),
    ]