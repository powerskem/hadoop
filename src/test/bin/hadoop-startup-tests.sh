#!/usr/bin/env bash

setUp()
{
    echo "starting processes"

    hadoop-daemon.sh start namenode
    hadoop-daemon.sh start datanode
    hadoop-daemon.sh start secondarynamenode
    yarn-daemon.sh start resourcemanager
    yarn-daemon.sh start nodemanager
    mr-jobhistory-daemon.sh start historyserver
}

tearDown()
{
    echo "stopping processes"

    mr-jobhistory-daemon.sh stop historyserver
    yarn-daemon.sh stop nodemanager
    yarn-daemon.sh stop resourcemanager
    hadoop-daemon.sh stop secondarynamenode
    hadoop-daemon.sh stop datanode
    hadoop-daemon.sh stop namenode
}

testProcessesStart()
{
    for processtotest in \
        $(echo -e "NameNode \nDataNode \nSecondaryNameNode \nResourceManager \nNodeManager \nJobHistoryServer")
    do
        i=$(jps | cut -d' ' -f 2 | grep -o --max-count=1 $processtotest )
        assertEquals "$processtotest is not running" "${processtotest}" "${i}"
    done
}

. ../lib/shunit2-2.1.6/src/shunit2
