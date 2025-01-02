# Borgbackup Server Container
![alt text](https://borgbackup.readthedocs.io/en/stable/_static/logo.png "Borgbackup")

### Description

Borgbackup Server Container is a fork of the original work from https://github.com/grantbevis/borg-server⁠

In this fork, I have updated all the packages to the latest version (at the time of writing) for the best of security and functionality.

Xem hướng dẫn sử dụng bằng Tiếng Việt tại đây: https://workleast.com/sao-luu-du-lieu-bang-borg-backup-docker/

### Usage
##### docker-compose.yml
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
##### .env
```
TZ=Asia/Ho_Chi_Minh
REPO_DIR=${HOME}/dump-repo
SSH_DIR=${PWD}/ssh
```
##### (Optional) Fix ownership
This container uses 'borg' user with uid(1000):gid(1000) to login and write the backup data to your the REPO_DIR directory (defined in .env file). Thus, if you are running the container on a user that differs from uid(1000):gid(1000), you need to execute the file 'fix-ownership.sh' to change the ownership first. Otherwise, you may encounter errors regarding permission problems.
```
sh fix-ownership.sh
```

#### Note
- Change the '${HOME}/dump-repo' in file '.env' to the actual path of your Borg's repository directory (where your data will be backed up to)
- Place your ssh's public keys in file 'ssh/authorized_keys'
- On the Borg's client, connect to the server using user 'borg' (eg. ssh://borg@your-server-ip:2022/backups)
