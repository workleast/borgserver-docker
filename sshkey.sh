#!/bin/sh
chown 1000:1000 /home/borg/.ssh
su - borg -c "ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''"
su - borg -c "cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys"
chmod 600 /home/borg/.ssh/*
su - borg -c "cat ~/.ssh/id_rsa"
