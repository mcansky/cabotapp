FROM python:2.7.10
MAINTAINER Thomas Riboulet <riboulet@gmail.com>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential nodejs libpq-dev python-dev npm git curl libldap2-dev \
        libsasl2-dev iputils-ping && \
    apt-get clean
RUN adduser cabot

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ADD . /home/cabot/src
WORKDIR /home/cabot/src

RUN npm install --no-color -g coffee-script less@1.3 --registry http://registry.npmjs.org/ && \
    ln -s /usr/bin/nodejs /usr/bin/node
RUN apt-get remove --auto-remove -y build-essential

ENV PYTHONPATH /home/cabot/src/

ENV DJANGO_SETTINGS_MODULE cabot.settings

RUN django-admin.py collectstatic --noinput && django-admin.py compress --force

USER cabot
