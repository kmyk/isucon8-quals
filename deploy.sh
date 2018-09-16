#!/bin/bash
set -e
ip1=118.27.22.252
ip2=118.27.20.60
ip3=118.27.29.133

scp -r etc isucon@${ip1}:
scp torb/db/schema.sql isucon@${ip1}:torb/db/
scp torb/webapp/env.sh isucon@${ip1}:torb/webapp/
scp torb/webapp/python/app.py isucon@${ip1}:torb/webapp/python/
scp -r torb/webapp/python/templates isucon@${ip1}:torb/webapp/python/
scp etc/systemd/system/torb.python.service isucon@${ip1}:etc/systemd/system/
scp etc/h2o/h2o.conf isucon@${ip1}:etc/h2o/

ssh isucon@${ip1} <<EOF
set -e
sudo cp etc/systemd/system/torb.python.service /etc/systemd/system/torb.python.service
sudo cp etc/h2o/h2o.conf /etc/h2o/h2o.conf
sudo systemctl daemon-reload
sudo systemctl restart mariadb
sudo systemctl restart torb.python.service
sudo systemctl restart h2o
./torb/db/init.sh
EOF
