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

# mitigate error - rsyslogd: imklog: cannot open kernel log (/proc/kmsg): Operation not permitted
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

COPY /rootfs /

HEALTHCHECK --interval=5s --timeout=2s --retries=3 --start-period=15s \
    CMD ps -ef|grep -v grep|grep 'rfbport 5900'

EXPOSE 5900


