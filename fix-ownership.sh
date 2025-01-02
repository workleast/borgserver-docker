#!/bin/sh
REPO_DIR=$(eval echo $(eval "grep REPO_DIR= .env | cut -d '=' -f2"))
SSH_DIR=$(eval echo $(eval "grep SSH_DIR= .env | cut -d '=' -f2"))
echo "Changing ownership of ${REPO_DIR} and ${SSH_DIR} to 1000:1000"
sudo chown -R 1000:1000 ${REPO_DIR} ${SSH_DIR} ${SSH_DIR}/* || echo "Failed to change ownership" exit 1
echo "Ownership changed"
