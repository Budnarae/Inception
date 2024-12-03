#!/bin/bash

apt update -y && apt install -y curl

echo "deb [by-hash=yes] http://repository.netdata.cloud/repos/stable/debian/ bookworm/"\
 | tee /etc/apt/sources.list.d/netdata.list
curl -sSL https://packages.netdata.cloud/netdata.asc | tee /etc/apt/trusted.gpg.d/netdata.asc

apt install -y netdata

exec netdata -D