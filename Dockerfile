FROM debian:10.3

WORKDIR /root

ADD . /root

RUN apt-get update && apt-get install -y python \
  supervisor \
  openssh-server \
  openssl \
  curl \
  libtool \
  tcpdump \
  vim \
  libssl-dev \
  psmisc \
  wget \
  man-db \
  apt-transport-https \
  python-pip \
  git \
  gcc \
  make \
  flex \
  hwloc \
  lua5.3 \
  net-tools \
  netcat \
  gnupg \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash","/root/entrypoint.sh"]
