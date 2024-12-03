FROM debian:12.6

COPY ./tools/set_vsftpd.sh /set_vsftpd.sh
RUN chmod +x /set_vsftpd.sh

RUN apt update -y && apt install -y vsftpd

COPY ./conf/vsftpd.conf /etc/vsftpd.conf

ENTRYPOINT ["/bin/bash", "-c", "/set_vsftpd.sh"]
