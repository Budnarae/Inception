FROM debian:12.6

COPY /tools/install_wordpress.sh /install_wordpress.sh

RUN ["chmod", "+x", "/install_wordpress.sh"]
RUN ["/bin/bash", "-c", "/install_wordpress.sh"]

#COPY /conf/wp_config.php /var/www/html/wp_config.php

COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY /tools/set_wordpress.sh /set_wordpress.sh

RUN ["chmod", "+x", "/set_wordpress.sh"]

ENTRYPOINT ["/bin/bash", "-c", "/set_wordpress.sh"]
