#!/usr/bin/python3.6
"""
WSGI config for Vmarts project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""

import os
import sys
from django.core.wsgi import get_wsgi_application
sys.path.append('/usr/local/lib/python3.6/dist-packages/django/')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Vmarts.settings')

application = get_wsgi_application()
