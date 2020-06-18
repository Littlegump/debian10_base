# 启动单节点 + rabbitmq Management UI
# auth auth_user && auth_pwd

## 单节点启动
docker run -d -p 15672:15672 -p 5672:5672 --name rmq38 yinkaixuan0213/debian10_base:rabbitmq-3.8

docker exec -it rmq38 /bin/bash

service rabbitmq-server start

rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user admin admin_pwd
rabbitmqctl set_permissions -p / admin ".*" ".*", ".*"
rabbitmqctl set_user_tags admin administrator 


## 多机器多实例集群启动
```
# 1. 部署 /前提是已经创建了testnetwork
docker run -d --network testnetwork -p 15672:15672 -p 5672:5672 yinkaixuan0213/debian10_base:rabbitmq-3.8
docker run -d --network testnetwork -p 15672:15672 -p 5672:5672 yinkaixuan0213/debian10_base:rabbitmq-3.8
docker run -d --network testnetwork -p 15672:15672 -p 5672:5672 yinkaixuan0213/debian10_base:rabbitmq-3.8

# 2. 进入容器执行
# n1: 
set /var/lib/rabbitmq/.erlang.cookie 0600
service rabbitmq-server start
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_management_agent
# n2:
set /var/lib/rabbitmq/.erlang.cookie 0600
service rabbitmq-server start
rabbitmq-plugins enable rabbitmq_management_agent
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster rabbit@<n1_hostname>
rabbitmqctl start_app
# n3:
set /var/lib/rabbitmq/.erlang.cookie 0600
service rabbitmq-server start
rabbitmq-plugins enable rabbitmq_management_agent
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster rabbit@<n1_hostname>
rabbitmqctl start_app
```

## 单机多实例集群部署
```
docker run -d -p 15672:15672 -p 5672:5672 --name rmq38 yinkaixuan0213/debian10_base:rabbitmq-3.8

docker exec -it rmq38 /bin/bash
RABBITMQ_NODE_PORT=5672 RABBITMQ_NODENAME=rabbit rabbitmq-server -detached
RABBITMQ_NODE_PORT=5673 RABBITMQ_NODENAME=hare rabbitmq-server -detached
rabbitmqctl -n hare stop_app
rabbitmqctl -n hare join_cluster rabbit@`hostname -s`
rabbitmqctl -n hare start_app
```

## 集群类型简介
一般情况下一个集群内至少需要一个disk节点，默认启动方式就是disk节点，其他节点都是ram
```
如何创建ram node
// 命令方式
rabbitmqctl stop_app
rabbitmqctl join_cluster --ram rabbitmq@node1
rabbitmqctl start_app
// 配置文件方式[todo]
如何改变节点类型
rabbitmqctl stop_app
rabbitmqctl change_cluster_node_type disc // 也可以是ram
rabbitmqct start_app
```
