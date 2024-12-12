#!/bin/sh

sudo mkdir /var/{run,log}/celery
sudo adduser celery --home /home/celery/
sudo chown -R celery:celery /var/{run,log}/celery
