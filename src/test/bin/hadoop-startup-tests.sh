#!/usr/bin/env bash

testStartAll()
{
    echo "starting processes"

    hadoop-daemon.sh start namenode
    hadoop-daemon.sh start datanode
    hadoop-daemon.sh start secondarynamenode
    yarn-daemon.sh start resourcemanager
    yarn-daemon.sh start nodemanager
    mr-jobhistory-daemon.sh start historyserver
}

testProcessesRunning()
{
    for processtotest in \
        $(echo -e "NameNode \nDataNode \nSecondaryNameNode \nResourceManager \nNodeManager \nJobHistoryServer")
    do
        assertEquals "$processtotest is not running" \
            "${processtotest}" \
            "$(jps | cut -d' ' -f 2 | grep -o --max-count=1 $processtotest )"
    done
}

testExample1()
{
    #hdfs dfs -rm -r books/out
    hadoop jar /usr/hdeco/hadoop-mapreduce/hadoop-mapreduce-examples.jar \
        grep books/Civilisation.txt books/out2 'my[a-z.]+'
}

testStopAll()
{
    echo "stopping processes"

    mr-jobhistory-daemon.sh stop historyserver
    yarn-daemon.sh stop nodemanager
    yarn-daemon.sh stop resourcemanager
    hadoop-daemon.sh stop secondarynamenode
    hadoop-daemon.sh stop datanode
    hadoop-daemon.sh stop namenode

    for processtotest in \
        $(echo -e "NameNode \nDataNode \nSecondaryNameNode \nResourceManager \nNodeManager \nJobHistoryServer")
    do
        assertEquals "$processtotest is still running" \
            "0" \
            "$(jps | cut -d' ' -f 2 | grep -c $processtotest )"
    done
}

. ../lib/shunit2-2.1.6/src/shunit2
