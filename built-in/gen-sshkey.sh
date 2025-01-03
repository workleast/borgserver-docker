#!/bin/sh
HOME_DIR=/home/borg

ssh-keygen -f $HOME_DIR/.ssh/id_rsa -t rsa -N ''
cp $HOME_DIR/.ssh/id_rsa.pub $HOME_DIR/.ssh/authorized_keys

chown -R borg:borg $HOME_DIR/.ssh
chmod 600 $HOME_DIR/.ssh/*

cat $HOME_DIR/.ssh/id_rsa
