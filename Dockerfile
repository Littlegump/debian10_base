FROM debian:10.3

WORKDIR /root

ADD . /root

RUN apt-get update && apt-get install -y python \
  supervisor \
  openssh-client \
  openssh-server \
  openssh-sftp-server \
  dnsutils \
  libstdc++6 \
  bzip2 \
  iptstate \
  openssl \
  curl \
  libtool \
  rsync \
  tcpdump \
  vim \
  libssl-dev \
  psmisc \
  wget \
  man-db \
  apt-transport-https \
  python-pip \
  python-dev \
  python-mysqldb \
  whois \
  smem \
  sudo \
  screen \
  iotop \
  iftop \
  locales \
  lsof \
  git \
  gcc \
  gdb \
  make \
  net-tools \
  dmidecode \
  netcat \
  gnupg \
  # basic app
  rsyslog \
  logrotate \
  cron \
  less \
  tree \
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
  && python -m pip install --upgrade pip \
  && pip install -U setuptools
 
EXPOSE 32200 514

ENTRYPOINT ["/bin/bash","/root/entrypoint.sh"]
