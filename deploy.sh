#!/bin/bash
set -e
ip1=111.111.111.111
ip2=222.222.222.222
ip3=123.123.123.123

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
