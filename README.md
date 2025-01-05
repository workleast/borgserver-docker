# Borgbackup Server Docker
![alt text](https://borgbackup.readthedocs.io/en/stable/_static/logo.png "Borgbackup")

## Description

Borgbackup Server Docker is a fork of the original work from https://github.com/grantbevis/borg-server⁠

In this fork, I have updated all the packages to the latest version (at the time of writing) for the best of security and functionality. I also fixed ownership errors that may occur on some linux distros.

Xem hướng dẫn sử dụng bằng Tiếng Việt tại đây: https://workleast.com/sao-luu-du-lieu-bang-borg-backup-docker/

## Usage
### docker-compose.yml
```
services:
  borgserver:
    restart: always
    image: workleast/borgserver
    container_name: borgserver
    volumes:
      - ${REPO_DIR}:/backups
      - ${SSH_DIR}:/home/borg/.ssh
    ports:
      - "2022:22"
    environment:
      TZ: ${TZ}
```
### .env
```
TZ=Asia/Ho_Chi_Minh
REPO_DIR=path/to/repo
SSH_DIR=${PWD}/ssh
```
- Change the 'TZ' variable to the time zone where you live
- Change the 'path/to/repo' to the actual path of your Borg's repository directory (where your data will be backed up to)
### ssh/authorized_keys
If you've already had your own SSH keys, place your ssh's public keys in the file 'ssh/authorized_keys'. Otherwise, you can use the built-in script to create one. Please see below for instruction.
## Run
```
docker compose up -d
```
### Fix permission
This container uses 'borg' user with uid(1000):gid(1000) to login and write backup data to the REPO_DIR directory on your host (defined in .env file). However, different systems usually have different uid:gid for their users which may result in permission problems. To workaround with this, I have added a script in the container which synchronizes the ownership and permission of relevant files and directories.
* Note: If you are re-using an existing Borg's repo, you also need to run this script to fix permission errors.
```
docker exec -it borgserver fix-permission.sh
```
### SSH keys auto-generate
If you are not using your own SSH keys, you can use this script to generate one. Here is how to get it done
```
docker exec -it borgserver gen-sshkey.sh
```
## Connect
- Upload the SSH's private key to the Borg Client
- On the Borg Client, connect to the Borg Server using ssh://borg@your-server-ip:2022/backups
