#!/bin/bash

RABBITMQ_NODE_PORT=5672 RABBITMQ_NODENAME=rabbit rabbitmq-server -detached
RABBITMQ_NODE_PORT=5673 RABBITMQ_NODENAME=hare rabbitmq-server -detached
rabbitmq-plugins -n rabbit enable rabbitmq_management
rabbitmq-plugins -n rabbit enable rabbitmq_management_agent
rabbitmq-plugins -n hare enable rabbitmq_management_agent
rabbitmqctl -n rabbit admin admin_pwd
rabbitmqctl -n rabbit set_permissions -p / admin ".*" ".*" ".*"
rabbitmqctl -n rabbit set_user_tags admin administrator
rabbitmqctl -n hare stop_app
rabbitmqctl -n hare join_cluster ram rabbit@`hostname -s`
rabbitmqctl -n hare start_app
