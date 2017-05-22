#!/usr/bin/env bash

setUp()
{
    echo "setting up"
   #HADOOP_DIR=/home/hduser
   #echo "HADOOP dir is $HADOOP_DIR "

   #cd $HADOOP_DIR && \
   #source .bashrc && \
   #cd - &> /dev/null
}

tearDown()
{
    echo "tearing down"
}

testHadoopConfDir()
{
    assertNotNull "HADOOP_CONF_DIR is not set" $HADOOP_CONF_DIR
    assertEquals "HADOOP_CONF_DIR is not set properly" "/home/hduser/hadoop/conf" "${HADOOP_CONF_DIR}"
    assertTrue "HADOOP_CONF_DIR is not writable" "[ -w $HADOOP_CONF_DIR ]"
}

. ../lib/shunit2-2.1.6/src/shunit2
