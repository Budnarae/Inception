FROM debian:12.6

COPY /tools/install_nginx.sh /

RUN chmod +x /install_nginx.sh && /install_nginx.sh

COPY /conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY /conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
COPY /tools/set_nginx.sh /

#보너스의 정적 웹페이지를 호스팅 하기 위한 파일들.
COPY /tools/Inception.pdf /tools/index.html /tools/styles.css /var/www/bonus/

RUN chmod +x /set_nginx.sh

ENTRYPOINT ["/bin/bash", "/set_nginx.sh"]