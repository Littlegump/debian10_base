#!/bin/bash
# author: urBearDaddy
# ref: https://www.rabbitmq.com/install-debian.html#apt-bintray-erlang

# add repo sign key
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | apt-key add -
apt-key adv --keyserver "hkps://keys.openpgp.org" --recv-keys "0x0A9AF2115F4687BD29803A206B73A36E6026DFCA"

# add buster source
# debian 9 might use Stretch
# ref: https://www.rabbitmq.com/install-debian.html#erlang-apt-https-transport
echo """
deb https://dl.bintray.com/rabbitmq-erlang/debian buster erlang-21.x
deb https://dl.bintray.com/rabbitmq/debian bionic main
""" > /etc/apt/sources.list.d/rabbitmq_erlang.list

# we can use --fix-missing to solve the problem of the erlang dependency
# or u'll use apt-get install erlang* like below
apt-get update -y && apt-get install rabbitmq-server -y --fix-missing


# install erlang
# apt-get update -y && apt-get install -y erlang-base \
#                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
#                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
#                        erlang-runtime-tools erlang-snmp erlang-ssl \
#                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
#

