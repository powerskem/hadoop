#!/usr/bin/env bash

    pref_HADOOP_DIR="/home/hduser"

    pref_HADOOP_CONF_DIR="/home/hduser/hadoop/conf"
    pref_YARN_CONF_DIR="/home/hduser/hadoop/conf"
    pref_MAPRED_CONF_DIR="/home/hduser/hadoop/conf"

    HDECO="/usr/hdeco"
    hdp_ver="2.3"
    pref_ver="2.7"


testHadoopConfDirs()
{
    # make sure HADOOP_CONF_DIR is set
    assertEquals "HADOOP_CONF_DIR is not set properly" \
        "${pref_HADOOP_CONF_DIR}" \
        "${HADOOP_CONF_DIR}"
    # make sure HADOOP_CONF_DIR is writable
    assertTrue "HADOOP_CONF_DIR is not writable" "[ -w $HADOOP_CONF_DIR ]"
}

testHadoopOperationalDir()
{
    # find out where $HDECO/hadoop is actually pointing
    cd -P $HDECO/hadoop && \
        actual_dir=$(pwd) && \
        cd - &> /dev/null

    # make sure it is pointing to the right place
    assertEquals "${HDECO}/hadoop (${actual_dir}) does not point to ver ${hdp_ver} --" \
        "${hdp_ver}" \
        "$(echo ${actual_dir} | grep -o ${hdp_ver})"

    # make sure /usr/bin/hadoop is pointing to the right place
    assertEquals "/usr/bin/hadoop is pointing to wrong place --" \
        "${pref_ver}" \
        "$(hadoop version 2>&1 | grep -m1 -o ${pref_ver})"
}

testVarRunDirs()
{
    # check that /var/run/hadoop exists and is writable
    assertTrue "/var/run/hadoop does not exist" "[ -d /var/run/hadoop ]"
    assertTrue "/var/run/hadoop is not writable" "[ -w /var/run/hadoop ]"
}

. ../lib/shunit2-2.1.6/src/shunit2
