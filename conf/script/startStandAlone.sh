#!/bin/bash

service rabbitmq-server start

rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user admin admin_pwd
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
rabbitmqctl set_user_tags admin administrator 

