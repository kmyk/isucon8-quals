#!/bin/bash
set -e
ip1=118.27.22.252
ip2=118.27.20.60
ip3=118.27.29.133

ip=${1:-$ip2}

echo "target ip = $ip"

scp -r etc isucon@${ip}:
scp torb/db/schema.sql isucon@${ip}:torb/db/

ssh isucon@${ip} <<EOF
set -e
sudo cp etc/my.cnf /etc/
sudo systemctl daemon-reload
sudo systemctl restart mariadb
./torb/db/init.sh
EOF
