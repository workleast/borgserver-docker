# Borg Backup Server Container
![alt text](https://borgbackup.readthedocs.io/en/stable/_static/logo.png "Borgbackup")

### Description

My take on a Borgbackup Server as a Docker container to faciliate the backing up of remote machines using [Borgbackup](https://github.com/borgbackup)

### Usage
#### Docker Compose
```
services:
  borg-server:
    restart: always
    image: ghcr.io/grantbevis/borg-server
    container_name: borgserver
    volumes:
      - path/to/repository:/backups
      - ./ssh/authorized_keys:/home/borg/.ssh/authorized_keys
    ports:
      - "2022:22"
    environment:
      TZ: "Asia/Ho_Chi_Minh"
```

##### Note
On the Borg's client, connect to the server using user 'borg' (eg. borg@your-server-ip:2022)

#### Docker Command

I personally like to split my ssh keys out of the main container to make updates and management easier. To achieve this I create a persistent storage container;

`docker run -d -v /home/borg/.ssh --name borg-keys-storage busybox:latest`

* Container Creation:
```
docker create \
  --name=borg-server \
  --restart=always \
  --volumes-from borg-keys-storage \
  -v path/to/backups:/backups \
  -p 2022:22 \
  ghcr.io/grantbevis/borg-server
```

##### Note
After creating the container you will need to start the container add your own public keys.
