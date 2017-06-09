#!/bin/bash

hadoop-daemon.sh start namenode & nn_pid=$! ; wait $nn_pid
if ps -p $nn_pid > /dev/null ; then
    echo "namenode not running"
    exit 1
fi

hadoop-daemon.sh start datanode & dn_pid=$! ; wait $dn_pid
ssh node2 "hadoop-daemon.sh start datanode"
ssh node3 "hadoop-daemon.sh start datanode"
#ssh node4 "hadoop-daemon.sh start datanode"
#ssh node5 "hadoop-daemon.sh start datanode"

yarn-daemon.sh start resourcemanager & rm_pid=$! ; wait $rm_pid
yarn-daemon.sh start nodemanager & rm_pid=$! ; wait $rm_pid

#yarn-daemon.sh start proxyserver

mr-jobhistory-daemon.sh start historyserver
