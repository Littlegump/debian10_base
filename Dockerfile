FROM yinkaixuan0213/debian10_base:latest

WORKDIR /root

ADD . /root

RUN bash install_rabbitmq_erlang.sh

EXPOSE 5672 15672 4369 5671 25672 35672-35682

ENTRYPOINT ["/bin/bash","/root/entrypoint.sh"]
