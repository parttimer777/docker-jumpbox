# docker-jumpbox

Based on linuxserver's [Debian BaseImage](https://github.com/linuxserver/docker-baseimage-debian). 

Docker-jumpbox is intended to be a simple & secure desktop container that can be used as a jumpbox.
* Lightweight desktop environment based on Openbox and TigerVNC
* Self-contained, includes noVNC as the web-based VNC client
* Built with s6 overlay so it can run custom startup scripts and services
* Includes Rsyslog and can be configured to send messages remotely by setting the docker environment

This image is continuously updated through github actions by checking the base image for updates (for those who use watchtowerr or auto-updates).

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
    - DISABLE_VNC_PASSWORD=false  # set to true to login to vnc without a password if you have other means of auth
  ports:
    - 6080:6080  # noVNC web service
  restart: unless-stopped
  secrets:
    - vncpasswd
```
