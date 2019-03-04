#!/bin/bash

/home/refresh.sh &

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf

