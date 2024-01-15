# docker-jumpbox

Based on linuxserver's [Debian BaseImage](https://github.com/linuxserver/docker-baseimage-debian). Docker-jumpbox runs openbox and tigervnc to provide a lightweight desktop environment. This is intended to be a simple & secure desktop container that can be used as a jumpbox.

Syslog can be configured to send messages remotely by setting the docker environment. Vnc server and rsyslogd have been configured to run as s6 services. With s6, the container can be customized with ease.

This image is continuously updated through github actions by checking the base image for updates.

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
