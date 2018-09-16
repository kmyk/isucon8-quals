#!/bin/bash
set -e
ip1=118.27.22.252
ip2=118.27.20.60
ip3=118.27.29.133

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
