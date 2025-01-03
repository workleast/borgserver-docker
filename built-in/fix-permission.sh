#!/bin/sh
REPO_DIR=/backups
SSH_DIR=/home/borg/.ssh

chown -R borg:borg $REPO_DIR $SSH_DIR || { echo "Failed to change ownership" && exit 1; }
chmod 600 $SSH_DIR/* || { echo "Failed to change permission" && exit 1; }
echo  "Ownerships and permissions are fixed successfully"
