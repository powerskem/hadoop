#!/bin/bash

mr-jobhistory-daemon.sh stop historyserver
#yarn-daemon.sh stop proxyserver
yarn-daemon.sh stop nodemanager
yarn-daemon.sh stop resourcemanager

hadoop-daemon.sh stop datanode
ssh node2 "hadoop-daemon.sh stop datanode"
ssh node3 "hadoop-daemon.sh stop datanode"
#ssh node4 "hadoop-daemon.sh stop datanode"
#ssh node5 "hadoop-daemon.sh stop datanode"

hadoop-daemon.sh stop namenode

