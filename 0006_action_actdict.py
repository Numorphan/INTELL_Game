# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-15 16:01
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('game', '0005_message'),
    ]

    operations = [
        migrations.AddField(
            model_name='action',
            name='actdict',
            field=models.CharField(max_length=1024, null=True),
        ),
    ]