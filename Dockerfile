# Dev for reactivex.github.io
FROM java:6
MAINTAINER Shixiong Zhu <zsxwing@gmail.com>

RUN apt-get update && apt-get install -y \
  openssh-server \
  vim

RUN service ssh start
RUN ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
RUN cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
RUN ssh-keyscan -H localhost >> ~/.ssh/known_hosts
RUN ssh-keyscan -H 127.0.0.1 >> ~/.ssh/known_hosts
RUN ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts

RUN wget http://www.us.apache.org/dist/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz
RUN mkdir /hadoop-dist
RUN mv hadoop-2.6.0.tar.gz /hadoop-dist/
RUN cd /hadoop-dist/ && tar zxf hadoop-2.6.0.tar.gz && rm hadoop-2.6.0.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
ENV HADOOP_HOME=/hadoop-dist/hadoop-2.6.0
ENV HADOOP_CONF_DIR=/hadoop-dist/hadoop-2.6.0/etc/hadoop

ADD start.sh /root/
ADD *.xml $HADOOP_CONF_DIR/
ADD hadoop-env.sh $HADOOP_CONF_DIR/

# HDFS

# dfs.http.address
EXPOSE 5070

# fs.default.name
EXPOSE 9000

# dfs.datanode.http.address
EXPOSE 50075

# dfs.datanode.address
EXPOSE 50010

# dfs.datanode.ipc.address
EXPOSE 50020

#YARN

# yarn.resourcemanager.webapp.address
EXPOSE 8088

# yarn.resourcemanager.address
EXPOSE 8032

# yarn.nodemanager.webapp.address
EXPOSE 50060

#SPARK
EXPOSE 4040

CMD /root/start.sh

