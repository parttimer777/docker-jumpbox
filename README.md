# docker-jumpbox

Based on linuxserver's [Debian BaseImage](https://github.com/linuxserver/docker-baseimage-debian). Docker-jumpbox is a lightweight desktop using openbox and tigervnc. Syslog on the container can be configured to send messages remotely by setting the docker environment.

This image is continuously updated through github actions by checking the baseimage for updates.

```
version: '3'

secrets:
  vncpasswd:
    file: ./vncpasswd.secret.txt

services:
 jumpbox:
  image: ghcr.io/parttimer777/docker-jumpbox:latest
  container_name: jumpbox
  hostname: jumpbox   # system's hostname
  environment:
    - PUID=1001
    - PGID=1001
    - TZ=America/New_York
    - VNC_USERNAME=${VNC_USERNAME:?err}
    - SYSLOG_TARGET_HOST=${SYSLOG_TARGET_HOST:?err}
    - SYSLOG_TARGET_PORT=${SYSLOG_TARGET_PORT:?err}
  restart: unless-stopped
  secrets:
    - vncpasswd
```
