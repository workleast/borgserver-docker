#!/bin/sh
REPO_DIR=$(eval echo $(eval "grep REPO_DIR= .env | cut -d '=' -f2"))
SSH_DIR=$(eval echo $(eval "grep SSH_DIR= .env | cut -d '=' -f2"))
echo "Creating configured directories (from .env file)"
mkdir ${REPO_DIR} || echo "${REPO_DIR} is already existed"
mkdir ${SSH_DIR} || echo "${SSH_DIR} is already existed"
echo "Changing ownership of ${REPO_DIR} and ${SSH_DIR} to 1000:1000"
sudo chown -R 1000:1000 ${REPO_DIR} ${REPO_DIR}/* ${SSH_DIR} ${SSH_DIR}/* || echo "Failed to change ownership" exit 1
echo "Ownership changed"
