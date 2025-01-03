#!/bin/sh
if [ $(id -u) -ne 0 ]
then
  echo "You need root permission, please retry with 'sudo' prefix."
  exit 1
fi

REAL_USER=
if [ $SUDO_USER ]
then
  REAL_USER=$SUDO_USER
else
  REAL_USER=$(whoami)
fi

ENV_FILE=".env"
REPO_DIR_VAR="REPO_DIR"
SSH_DIR_VAR="SSH_DIR"

if [ ! -f $ENV_FILE ]
then
  echo "File .env not found"
  exit 1
fi

REPO_DIR_STR=$(eval "grep ^${REPO_DIR_VAR}= $ENV_FILE | tail -1 | cut -d '=' -f2")
REPO_DIR=$(eval "sudo -u $REAL_USER -H -s eval 'echo $REPO_DIR_STR'")

SSH_DIR_STR=$(eval "grep ^${SSH_DIR_VAR}= $ENV_FILE | tail -1 | cut -d '=' -f2")
SSH_DIR=$(eval "sudo -u $REAL_USER -H -s eval 'echo $SSH_DIR_STR'")

if [ ! $REPO_DIR_STR ] || [ ! $SSH_DIR_STR ]
then
  echo "Required configured variables not found. Plese check your .env file"
  exit 1
fi

echo "- Creating configured directories (from .env file)"
echo "REPO_DIR=$REPO_DIR"
echo "SSH_DIR=$SSH_DIR"

if [ ! -d "$REPO_DIR" ]
then
  mkdir ${REPO_DIR}
else
  echo "$REPO_DIR already exists"
fi

if [ ! -d "$SSH_DIR" ]
then
  mkdir ${SSH_DIR}
else
  echo "$SSH_DIR already exists"
fi

echo "- Changing ownership to 1000:1000"
chown -R 1000:1000 ${REPO_DIR} ${SSH_DIR} || { echo "Failed to change ownership" && exit 1; }
echo "Ownership changed successfully"
echo "- Changing permission of files in ${SSH_DIR} to 600"
chmod 600 ${SSH_DIR}/* || { echo "Failed to change permission" && exit 1; }
echo "Permission changed successfully"
