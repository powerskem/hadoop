#!/bin/bash

mr-jobhistory-daemon.sh stop historyserver
yarn-daemon.sh stop nodemanager
yarn-daemon.sh stop resourcemanager
hadoop-daemon.sh stop secondarynamenode
hadoop-daemon.sh stop datanode
hadoop-daemon.sh stop namenode

