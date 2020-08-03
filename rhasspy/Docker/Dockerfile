FROM python:3.7.7-buster

ARG UID=1000
ARG GID=1000

ENV GROUPID=$GID
ENV USERID=$UID

ENV TERM=screen-256color

ENV USER=pi
ENV HOME=/home/$USER


RUN set -xe \
    && cd / \
    && sed -i "s/ main/ main non-free/g" /etc/apt/sources.list \
    && apt-get update && apt-get dist-upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
        sudo \
        gnupg2 \
        dirmngr \
        apt-transport-https \
        apt-utils \
    && groupadd --gid ${GROUPID} ${USER} \
    && useradd --uid ${USERID} --gid ${GROUPID} --create-home --shell /bin/bash $USER \
    && echo 'export PATH="$PATH:$HOME/bin"' >> $HOME/.bashrc \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && chown -R $USER:$USER $HOME \
    && usermod -a -G audio ${USER} \
    && apt update \
    && apt dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt install -y  \
        tzdata \
        mc joe less \
        curl \
        wget \
        zip \
        unzip \
        git \
        psmisc \
        procps \
        supervisor \
        alsa-utils \
        gcc \
        make \
        pkg-config \
        automake \
        libtool \
        libatlas-base-dev \
        portaudio19-dev \
        python3-pyaudio \
        python3-venv \
        python3-setuptools \
        python3-pip \
        build-essential \
        sox \
        libgfortran4 \
        swig \
        espeak \
        flite \
        perl \
        patchelf \
        ca-certificates \
        mosquitto \
        mosquitto-clients \
    && apt-get clean \
    && apt-get -y auto-remove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN set -xe \
    && apt-get update

# libfst-tools libngram-tools  ??


USER $USER
WORKDIR $HOME



#ENTRYPOINT ["/tini", "--"]
#CMD ["/bin/bash","/start-scripts/start-snips.sh"]
CMD ["tail", "-f", "/dev/null"]
