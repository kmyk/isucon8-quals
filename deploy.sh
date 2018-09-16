#!/bin/bash
set -e
ip1=118.27.22.252
ip2=118.27.20.60
ip3=118.27.29.133

ip=${1:-$ip1}

echo "target ip = $ip"

scp -r etc isucon@${ip}:
scp torb/webapp/env.sh isucon@${ip}:torb/webapp/
scp torb/webapp/python/*.py isucon@${ip}:torb/webapp/python/
scp torb/webapp/python/*.sh isucon@${ip}:torb/webapp/python/
scp -r torb/webapp/python/templates isucon@${ip}:torb/webapp/python/
scp etc/systemd/system/torb.python.service isucon@${ip}:etc/systemd/system/
scp etc/h2o/h2o.conf isucon@${ip}:etc/h2o/

ssh isucon@${ip} <<EOF
set -e
sudo cp etc/systemd/system/torb.python.service /etc/systemd/system/torb.python.service
sudo cp etc/h2o/h2o.conf /etc/h2o/h2o.conf
sudo systemctl daemon-reload
sudo systemctl restart torb.python.service
sudo systemctl restart h2o
EOF
