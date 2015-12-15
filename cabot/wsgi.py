import os

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'cabot.settings')

import django.core.handlers.wsgi
from whitenoise.django import DjangoWhiteNoise

application = django.core.handlers.wsgi.WSGIHandler()
application = DjangoWhiteNoise(application)

