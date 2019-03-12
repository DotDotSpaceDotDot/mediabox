#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt update && apt full-upgrade
apt install curl git python bridge-utils net-tools

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose -v

usermod -aG docker $USER

/sbin/modprobe iptable_mangle

read -r -p "Press any key to continue... " -n1 -s
printf "\\n\\n"

reboot