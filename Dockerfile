FROM yinkaixuan0213/debian10_base:latest

WORKDIR /root

ADD . /root

RUN bash install_rabbitmq_erlang.sh

EXPOSE 5672 15672

ENTRYPOINT ["/bin/bash","/root/entrypoint.sh"]
