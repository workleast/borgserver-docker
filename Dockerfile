FROM alpine:20240923
LABEL maintainer="workleast.com"

#Install Borg & SSH
RUN apk add --no-cache \
    tzdata=2024b-r1 \
    openssh=9.9_p1-r2 \
    sshfs=3.7.3-r1 \
    borgbackup=1.4.0-r0 \
    supervisor=4.2.5-r5
RUN adduser -D -u 1000 borg && \
    passwd -u borg && \
    mkdir -m 0700 /backups && \
    chown borg.borg /backups && \
    sed -i \
        -e 's/^#PasswordAuthentication yes$/PasswordAuthentication no/g' \
        -e 's/^PermitRootLogin without-password$/PermitRootLogin no/g' \
        /etc/ssh/sshd_config

RUN mkdir /home/borg/.ssh
RUN chown borg.borg /home/borg/.ssh

COPY built-in/supervisord.conf /etc/supervisord.conf
COPY built-in/service.sh /usr/local/bin/service.sh
COPY built-in/gen-sshkey.sh /usr/local/bin/gen-sshkey.sh
COPY built-in/fix-permission.sh /usr/local/bin/fix-permission.sh

RUN chmod +x /usr/local/bin/service.sh
RUN chmod +x /usr/local/bin/gen-sshkey.sh
RUN chmod +x /usr/local/bin/fix-permission.sh

EXPOSE 22
VOLUME /etc/ssh

CMD ["/usr/bin/supervisord"]
