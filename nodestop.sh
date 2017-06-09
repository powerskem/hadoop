#!/bin/bash

mr-jobhistory-daemon.sh stop historyserver
#yarn-daemon.sh stop proxyserver
yarn-daemon.sh stop nodemanager
yarn-daemon.sh stop resourcemanager & rm_pid=$! ; wait $rm_pid

hadoop-daemon.sh stop datanode & dn_pid=$! ; wait $dn_pid
ssh node2 "hadoop-daemon.sh stop datanode" & nn2_pid=$!
ssh node3 "hadoop-daemon.sh stop datanode" & nn3_pid=$!
#ssh node4 "hadoop-daemon.sh stop datanode" & nn4_pid=$!
#ssh node5 "hadoop-daemon.sh stop datanode" & nn5_pid=$!

hadoop-daemon.sh stop namenode & nn_pid=$! ; wait $nn_pid

