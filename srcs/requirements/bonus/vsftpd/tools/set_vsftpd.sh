#!/bin/bash

useradd -m ${FTPUSER}
echo -e "${FTPUSER}:${FTPPASS}" | chpasswd ${FTPUSER}

mkdir -p /var/run/vsftpd/empty/

echo ${FTPUSER} > /etc/vsftpd.user_list

exec vsftpd /etc/vsftpd.conf
