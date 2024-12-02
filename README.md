# Borgbackup Server Container
![alt text](https://borgbackup.readthedocs.io/en/stable/_static/logo.png "Borgbackup")

### Description

Borgbackup Server Container is a fork of the original work from https://github.com/grantbevis/borg-server⁠

In this fork, I have updated all the packages to the latest version (at the time of writing) for the best of security and functionality.

Xem hướng dẫn sử dụng bằng Tiếng Việt tại đây: https://workleast.com/sao-luu-du-lieu-bang-borg-backup-docker/

### Usage
```
services:
  borg-server:
    restart: always
    image: workleast/borg-server
    container_name: borg-server
    volumes:
      - path/to/repository:/backups
      - ./ssh/authorized_keys:/home/borg/.ssh/authorized_keys
    ports:
      - "2022:22"
    environment:
      TZ: "Asia/Ho_Chi_Minh"
```

#### Note
- Change the 'path/to/repository' in file 'docker-compose.yml' to the actual path of your Borg's repository
- Place your ssh's public keys in file 'ssh/authorized_keys'
- On the Borg's client, connect to the server using user 'borg' (eg. ssh://borg@your-server-ip:2022/backups)
