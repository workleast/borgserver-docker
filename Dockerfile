FROM alpine:edge
LABEL maintainer="workleast"

#Install Borg & SSH
RUN apk add --no-cache \
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

COPY supervisord.conf /etc/supervisord.conf
COPY service.sh /usr/local/bin/service.sh
COPY sshkey.sh /usr/local/bin/sshkey.sh

RUN chmod +x /usr/local/bin/sshkey.sh
RUN chmod +x /usr/local/bin/service.sh

EXPOSE 22
VOLUME /etc/ssh

CMD ["/usr/bin/supervisord"]
