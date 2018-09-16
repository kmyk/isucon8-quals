#!/bin/bash
set -e
ip1=111.111.111.111
ip2=222.222.222.222
ip3=123.123.123.123

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
