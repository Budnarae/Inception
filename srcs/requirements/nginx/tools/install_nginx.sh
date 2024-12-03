#!/bin/bash

apt update -y && apt upgrade -y

apt install -y curl gnupg2 ca-certificates lsb-release debian-archive-keyring
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
| tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
gpg --dry-run --quiet --no-keyring --import --import-options \
import-show /usr/share/keyrings/nginx-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/debian `lsb_release -cs` nginx" \
| tee /etc/apt/sources.list.d/nginx.list
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
| tee /etc/apt/preferences.d/99nginx

apt update -y
apt install -y nginx openssl gettext

# execute openssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt \
-subj "/C=KR/ST=seoul/L=Gaepo-dong/O=42Seoul/OU=Member/CN=sihong Certificate"

# 보너스 항목(정적 웹페이지 호스팅)을 위한 경로 설정
mkdir -p /var/www/bonus
