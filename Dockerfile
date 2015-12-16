FROM python:2.7.10
MAINTAINER Thomas Riboulet <riboulet@gmail.com>

# Prepare
RUN apt-get update && apt-get install -y build-essential nodejs libpq-dev python-dev npm git curl libldap2-dev libsasl2-dev iputils-ping && apt-get clean
RUN adduser cabot
ADD gunicorn.conf /etc/cabot/gunicorn.conf

# Checkout Code
ADD . /home/cabot/src/

# Install dependencies
RUN pip install -e /home/cabot/src/
RUN npm install --no-color -g coffee-script less@1.3 --registry http://registry.npmjs.org/ && ln -s /usr/bin/nodejs /usr/bin/node
RUN apt-get remove --auto-remove -y build-essential

# Set env var
ENV PYTHONPATH $PYTHONPATH:/home/cabot/src/
ENV LOG_FILE=/var/log/cabot.log

# Cabot settings
ENV DJANGO_SETTINGS_MODULE cabot.settings

RUN django-admin.py collectstatic --noinput && django-admin.py compress --force 

# PORT
ENV PORT 8000
EXPOSE 8000

WORKDIR /home/cabot/src
ADD gunicorn.conf gunicorn.conf

