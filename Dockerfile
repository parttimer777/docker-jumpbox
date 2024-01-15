FROM ghcr.io/linuxserver/baseimage-debian:bookworm

RUN \
    echo "**** install packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        openbox \
        xfce4-terminal \
        vim.tiny \ 
        menu \
        tigervnc-standalone-server \
        tigervnc-tools \
        firefox-esr \
        x11-xserver-utils \
        openssh-client \
        sudo \
        rsyslog && \
    echo "**** cleanup ****" && \
    apt-get autoclean && \
    rm -rf \
        /config/.cache \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

RUN echo "alias vim='vim.tiny'" >> /etc/bash.bashrc

#   healthcheck:
#     test: ps -ef|grep -v grep|grep 'rfbport 5900'
#     interval: 20s
#     timeout: 3s
#     retries: 3
#     start_period: 15s

EXPOSE 5900


