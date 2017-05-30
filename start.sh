#!/bin/bash

hadoop-daemon.sh start namenode & nn_pid=$! ; wait $nn_pid
if ps -p $nn_pid > /dev/null ; then
    echo "namenode not running"
    exit 1
fi

hadoop-daemon.sh start datanode & dn_pid=$! ; wait $dn_pid
if ps -p $dn_pid > /dev/null ; then
    echo "datanode not running"
    exit 1
fi

hadoop-daemon.sh start secondarynamenode & sn_pid=$! ; wait $sn_pid
if ps -p $sn_pid > /dev/null ; then
    echo "secondarynamenode not running"
    exit 1
fi

yarn-daemon.sh start resourcemanager & rm_pid=$! ; wait $rm_pid
if ps -p $rm_pid > /dev/null ; then
    echo "resourcemanager not running"
    exit 1
fi

yarn-daemon.sh start nodemanager & nm_pid=$! ; wait $nm_pid
if ps -p $nm_pid > /dev/null ; then
    echo "nodemanager not running"
    exit 1
fi

mr-jobhistory-daemon.sh start historyserver & hs_pid=$! ; wait $hs_pid
if ps -p $hs_pid > /dev/null ; then
    echo "historyserver not running"
    exit 1
fi
