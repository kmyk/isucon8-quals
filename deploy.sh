#!/bin/bash
set -e
ip1=118.27.22.252
ip2=118.27.20.60
ip3=118.27.29.133

ip=${1:-$ip1}

echo "target ip = $ip"

scp -r etc isucon@${ip}:
scp torb/db/schema.sql isucon@${ip}:torb/db/
scp torb/webapp/env.sh isucon@${ip}:torb/webapp/
scp torb/webapp/python/*.py isucon@${ip}:torb/webapp/python/
scp torb/webapp/python/*.sh isucon@${ip}:torb/webapp/python/
scp -r torb/webapp/python/templates isucon@${ip}:torb/webapp/python/
scp etc/systemd/system/torb.python.service isucon@${ip}:etc/systemd/system/
scp etc/systemd/system/torb.python.socket isucon@${ip}:etc/systemd/system/
scp -r etc/tmpfiles.d/torb.python.conf isucon@${ip}:etc/tmpfiles.d/
scp etc/h2o/h2o.conf isucon@${ip}:etc/h2o/

ssh isucon@${ip} <<EOF
set -e
sudo cp etc/systemd/system/torb.python.service /etc/systemd/system/torb.python.service
sudo cp etc/systemd/system/torb.python.socket /etc/systemd/system/torb.python.socket
sudo cp -r etc/tmpfiles.d/torb.python.conf /etc/tmpfiles.d/torb.python.conf
sudo cp etc/h2o/h2o.conf /etc/h2o/h2o.conf
sudo systemctl daemon-reload
sudo systemctl restart mariadb
sudo systemctl restart torb.python.service
sudo systemctl restart torb.python.socket
sudo systemctl restart h2o
./torb/db/init.sh
EOF
