#!/usr/bin/env bash
trap "exit 0" TERM
top_pid=$$

oneTimeSetUp() {
    input_file="Civil.txt"
    mydate="$(date +%Y-%m-%d_%H%M%S)"
    output_folder="testout_${mydate}"

    echo "PID is $top_pid"
    echo "starting processes"

    hadoop-daemon.sh start namenode
    hadoop-daemon.sh start datanode
    hadoop-daemon.sh start secondarynamenode
    yarn-daemon.sh start resourcemanager
    yarn-daemon.sh start nodemanager
    mr-jobhistory-daemon.sh start historyserver
}

testProcessesRunningBefore() {
    for processtotest in \
        $(echo -e "NameNode \nDataNode \nSecondaryNameNode \nResourceManager \nNodeManager \nJobHistoryServer")
    do
        assertEquals "$processtotest is not running" \
            "${processtotest}" \
            "$(jps | cut -d' ' -f 2 | grep -o --max-count=1 $processtotest )"
    done
}

testFsck() {
    assertEquals "File system / is not healthy" \
        "Status: HEALTHY" \
        "$(hdfs fsck / 2>&1 | grep -o --max-count=1 'Status: HEALTHY' )"
}

testInputExists() {
    assertNotEquals "Input file ${input_file} doesn't exist" \
        "No such file or dir" \
        "$(hdfs dfs -ls 2>&1 | grep -o --max-count=1 'No such file or dir')"
}

testOutputFolderDoesntExist() {
    assertEquals "Output folder ${output_folder} exists already" \
        "No such file or dir" \
        "$(hdfs dfs -ls ${output_folder} 2>&1 | grep -o --max-count=1 'No such file or dir' )"
}

testMapredGrep() {
    hadoop jar /usr/hdeco/hadoop-mapreduce/hadoop-mapreduce-examples.jar \
        grep ${input_file} ${output_folder} 'my[a-z.]+' 2> /tmp/hout_${mydate} & testpid=$!
    wait $testpid
    for job in \
        $(grep "Running job:" /tmp/hout_${mydate} |cut -d' ' -f7)
    do
        assertEquals "Job $job was not completed successfully" \
            "successfully" \
            "$(grep $job /tmp/hout_${mydate} | grep completed | grep -o successfully)"
    done
    assertEquals "Mapreduce grep example did not produce correct result." \
        "11" \
        "$(hdfs dfs -cat ${output_folder}/part-r-00000 2>&1 | grep mythological | grep -o 11)"
}

testProcessesRunningAfter() {
    for processtotest in \
        $(echo -e "NameNode \nDataNode \nSecondaryNameNode \nResourceManager \nNodeManager \nJobHistoryServer")
    do
        assertEquals "$processtotest is no longer running (after runs)" \
            "${processtotest}" \
            "$(jps | cut -d' ' -f 2 | grep -o --max-count=1 $processtotest )"
    done
}

testStopAll() {
    hdfs dfs -rm -r $output_folder
    rm -rf /tmp/hout_${mydate}
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
oneTimeTearDown() {
    echo done
}

. ../lib/shunit2-2.1.6/src/shunit2
