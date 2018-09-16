#!/bin/bash
set -e
ip1=111.111.111.111
ip2=222.222.222.222
ip3=123.123.123.123

scp -r etc isucon@${ip1}:
scp -r usr isucon@${ip1}:
scp torb/db/schema.sql isucon@${ip1}:torb/db/
scp torb/webapp/env.sh isucon@${ip1}:torb/webapp/
scp torb/webapp/python/app.py isucon@${ip1}:torb/webapp/python/
scp -r torb/webapp/python/templates isucon@${ip1}:torb/webapp/python/

ssh isucon@${ip} <<EOF
set -e
sudo systemctl daemon-reload
sudo systemctl restart mariadb
sudo systemctl restart torb.python.service
sudo systemctl restart h2o
./torb/db/init.sh
EOF
