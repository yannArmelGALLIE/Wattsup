# Generated by Django 5.2.2 on 2025-06-06 12:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='compteur',
            name='identifiant_compteur',
            field=models.IntegerField(primary_key=True, serialize=False),
        ),
        migrations.AlterField(
            model_name='compteur',
            name='numero_compteur',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='compteur',
            name='reference',
            field=models.IntegerField(),
        ),
        migrations.AlterField(
            model_name='compteur',
            name='type_client',
            field=models.IntegerField(),
        ),
    ]
