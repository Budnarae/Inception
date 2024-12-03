FROM debian:12.6

COPY /tools/set_mariadb.sh /

RUN chmod +x /set_mariadb.sh

ENTRYPOINT ["/bin/bash", "-c", "/set_mariadb.sh"]