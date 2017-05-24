#!/usr/bin/env bash

setUp()
{
    echo "setting up"
    pref_ver="1.7"
}

tearDown()
{
    echo "tearing down"
}

testJavaHomeEnvVar()
{
    # make sure JAVA_HOME is set
    assertEquals "JAVA_HOME is not set --" \
            "java" \
            "$(echo ${JAVA_HOME} | grep -o java)"

    # get version that the environment is running
    java_version=$(java -version 2>&1 | grep version |cut -f2 -d'"')

    # find out where JAVA_HOME is actually pointing
    cd -P $JAVA_HOME && \
        actual_dir=$(pwd) && \
        cd - &> /dev/null

    # make sure JAVA_HOME is pointing to the right place
    assertEquals "JAVA_HOME ${actual_dir} does not point to ver ${pref_ver} --" \
        "${pref_ver}" \
        "$(echo ${actual_dir} | cut -f2 -d'-' | grep -o ${pref_ver})"

    # make sure /usr/bin/java is pointing to the right place
    assertEquals "java alternatives are set up wrong --" \
        "${pref_ver}" \
        "$(java -version 2>&1 | grep -o ${pref_ver})"

}

. ../lib/shunit2-2.1.6/src/shunit2
