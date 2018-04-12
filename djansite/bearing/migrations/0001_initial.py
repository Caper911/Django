# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-04-09 01:56
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='cpuInfo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('value', models.FloatField()),
                ('time', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='factory',
            fields=[
                ('factorID', models.AutoField(default=1001, primary_key=True, serialize=False)),
                ('factorDes', models.CharField(max_length=100)),
                ('location', models.CharField(max_length=200)),
                ('areaCode', models.CharField(max_length=6)),
                ('personInCharge', models.CharField(max_length=12)),
                ('phoneNumber', models.CharField(blank=True, max_length=11)),
                ('otherInfo', models.TextField(blank=True, null=True)),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('modDate', models.DateTimeField(auto_now=True, verbose_name='最后修改日期')),
            ],
        ),
        migrations.CreateModel(
            name='ioInfo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('value', models.FloatField()),
                ('time', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='machine',
            fields=[
                ('machineID', models.AutoField(default=10000001, primary_key=True, serialize=False)),
                ('machineDes', models.CharField(max_length=100)),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('modDate', models.DateTimeField(auto_now=True, verbose_name='最后修改日期')),
                ('otherInfo', models.TextField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='memoryInfo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('valueUsed', models.FloatField()),
                ('memPercent', models.FloatField()),
                ('time', models.DateTimeField()),
                ('machine', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='bearing.machine')),
            ],
        ),
        migrations.CreateModel(
            name='opStartEnddate',
            fields=[
                ('opCodeID', models.AutoField(primary_key=True, serialize=False)),
                ('startDate', models.DateField()),
                ('endDate', models.DateField()),
            ],
        ),
        migrations.CreateModel(
            name='productDepart',
            fields=[
                ('departID', models.AutoField(default=100001, primary_key=True, serialize=False)),
                ('depatrDes', models.CharField(max_length=100)),
                ('personInCharge', models.CharField(max_length=12)),
                ('otherInfo', models.TextField(blank=True, null=True)),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('modDate', models.DateTimeField(auto_now=True, verbose_name='最后修改日期')),
                ('factory', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.factory')),
            ],
        ),
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('phonenumber', models.CharField(blank=True, max_length=11)),
                ('avatar', models.ImageField(blank=True, null=True, upload_to='photo')),
                ('gender', models.IntegerField(default=0)),
                ('otherText', models.TextField(blank=True, null=True)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='sensorInfo',
            fields=[
                ('sensorID', models.AutoField(default=10, primary_key=True, serialize=False)),
                ('description', models.CharField(max_length=100)),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('modDate', models.DateTimeField(auto_now=True, verbose_name='最后修改日期')),
                ('machine', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='bearing.machine')),
            ],
        ),
        migrations.CreateModel(
            name='sensorRawData',
            fields=[
                ('sensorID', models.AutoField(primary_key=True, serialize=False)),
                ('sesorValue', models.FloatField()),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('opStartEnddate', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.opStartEnddate')),
                ('sensorInfo', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.sensorInfo')),
            ],
        ),
        migrations.CreateModel(
            name='sensorWaveletData',
            fields=[
                ('sensorID', models.AutoField(primary_key=True, serialize=False)),
                ('sesorValue', models.FloatField()),
                ('saveDate', models.DateTimeField(default=django.utils.timezone.now, verbose_name='保存日期')),
                ('opStartEnddate', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.opStartEnddate')),
                ('sensorInfo', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.sensorInfo')),
            ],
        ),
        migrations.AddField(
            model_name='opstartenddate',
            name='sensorID',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.sensorInfo'),
        ),
        migrations.AddField(
            model_name='machine',
            name='productDepart',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bearing.productDepart'),
        ),
        migrations.AddField(
            model_name='ioinfo',
            name='machine',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='bearing.machine'),
        ),
        migrations.AddField(
            model_name='cpuinfo',
            name='machine',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='bearing.machine'),
        ),
    ]
