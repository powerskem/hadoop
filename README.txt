#####################################
hadoop

by Kathleen P Chase
#####################################

This is a maven repository for running Hadoop in a Linux environment.


# To clone:
su hduser
cd ~
git init
git remote add origin https://github.com/powerskem/hadoop.git
git pull origin master
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config --global push.default matching
. ./.bashrc


# To test:
mvn clean test -P linux


# To run:
./start.sh ;    # wait a min longer for NameNode to leave safe mode
hdfs namenode -format
hdfs dfs -mkdir -p /user/hduser
hdfs dfs -put $path_to_Civil.txt /user/hduser/
hdfs dfs -ls ;  # check for input file Civil.txt

hadoop jar $HADOOP_MAPRED_HOME/hadoop-mapreduce-examples.jar grep Civil.txt out 'my[a-z.]+'
hdfs dfs -ls out
hdfs dfs -cat out/part-r-00000 | head

hadoop jar $HADOOP_MAPRED_HOME/hadoop-mapreduce-examples.jar wordcount Civil.txt out
hdfs dfs -ls out
hdfs dfs -cat out/part-r-00000 | sort -k2 n | tail

hadoop jar $HADOOP_MAPRED_HOME/hadoop-mapreduce-examples.jar pi 2 2


# To check for errors:
mydate="$(date +%Y-%m-%d)"
mydatewhr="$(date +%Y-%m-%d\ %H)"
grep -r ERR /home/hduser/hadoop/log/* |grep $mydate
find -L /home/hduser/hadoop/log -mtime -1 | xargs /bin/ls -atd1Lp
find -L /home/hduser/hadoop/log -mmin -5 | xargs /bin/ls -atd1Lp
find -L /home/hduser/hadoop/log -mmin -5 | xargs /bin/grep -s ERR -c
find -L /home/hduser/hadoop/log -mmin -5 | xargs /bin/grep -s ERR -l
find -L /home/hduser/hadoop/log -mmin -5 | xargs /bin/grep -s ERR -l | xargs /bin/grep -s ERR | grep "$mydatewhr"


# To check web server:
lynx http://hdcentos:50070
lynx http://hdcentos:8088


