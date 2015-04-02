#!/bin/bash -e

cd $HADOOP_HOME

bin/hdfs namenode -format

sbin/start-dfs.sh

bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/zsx

sbin/start-yarn.sh

