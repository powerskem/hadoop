#!/usr/bin/env bash

setUp()
{
    echo "setting up"
    HADOOP_DIR=/home/hduser
    echo "HADOOP dir is $HADOOP_DIR "
}

tearDown()
{
    echo "tearing down"
}

testHadoopConfDir()
{
    cd $HADOOP_DIR && \
    source .bashrc && \
    cd - &> /dev/null

    assertEquals "HADOOP_CONF_DIR is not set properly" "/home/hduser/hadoop/conf" "${HADOOP_CONF_DIR}"

    if [ -w $HADOOP_CONF_DIR ] ; then writable="true" ; else writable="false" ; fi

    assertEquals "HADOOP_CONF_DIR is not writable" "true" "$writable"
}

. ../lib/shunit2-2.1.6/src/shunit2
