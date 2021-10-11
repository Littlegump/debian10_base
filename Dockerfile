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
  mtr \
  dig \
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

# etcd installed
RUN wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz \
  && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz \
  && export PATH=$PATH:/usr/local/go/bin \
  && git clone -b v3.5.0 https://github.com/etcd-io/etcd.git \
  && cd etcd \
  && ./build.sh \
  && export PATH="$PATH:`pwd`/bin"

EXPOSE 32200 514

ENTRYPOINT ["/bin/bash","/root/entrypoint.sh"]
