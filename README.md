# Borgbackup Server Container
![alt text](https://borgbackup.readthedocs.io/en/stable/_static/logo.png "Borgbackup")

### Description

Borgbackup Server Container is a fork of the original work from https://github.com/grantbevis/borg-server⁠

In this fork, I have updated all the packages to the latest version (at the time of writing) for the best of security and functionality. I also fixed ownership errors that may occur on some linux distros.

Xem hướng dẫn sử dụng bằng Tiếng Việt tại đây: https://workleast.com/sao-luu-du-lieu-bang-borg-backup-docker/

### Usage
#### * docker-compose.yml
```
services:
  borg-server:
    restart: always
    image: workleast/borg-server
    container_name: borg-server
    volumes:
      - ${REPO_DIR}:/backups
      - ${SSH_DIR}/authorized_keys:/home/borg/.ssh/authorized_keys
    ports:
      - "2022:22"
```
#### * .env
```
TZ=Asia/Ho_Chi_Minh
REPO_DIR=${HOME}/dump-repo
SSH_DIR=${PWD}/ssh
```
- Change the 'TZ' variable to the time zone where you live
- Change the '${HOME}/dump-repo' in file '.env' to the actual path of your Borg's repository directory (where your data will be backed up to)
#### * ssh/authorized_keys
Place your ssh's public keys in the file 'ssh/authorized_keys'
#### * execute file init.sh
This container uses 'borg' user with uid(1000):gid(1000) to login and write backup data to the REPO_DIR directory (defined in .env file). Thus, this step is to make sure all required files and directories are with proper ownership. Otherwise, you may encounter errors regarding permission problems.
```
sh init.sh
```
#### * connect
On the Borg's client, connect to the server using user 'borg' (eg. ssh://borg@your-server-ip:2022/backups)
