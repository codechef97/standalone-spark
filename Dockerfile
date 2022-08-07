# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM centos:centos7

ENV SPARK_PROFILE 2.12
ENV SPARK_VERSION 3.3.0
ENV HADOOP_PROFILE 3
ENV SPARK_HOME /usr/local/spark
ENV HADOOP_CONF_DIR /usr/lib/hadoop
ENV SPARK_SUBMIT_OPTIONS --packages com.databricks:spark-csv_2.10:1.2.0

# Update the image with the latest packages
RUN yum update -y; yum clean all

# Get utils
RUN yum install -y \
wget \
tar \
curl \
&& \
yum clean all

# Remove old jdk
RUN yum remove java; yum remove jdk

# install jdk7
RUN yum install -y java-1.8.0-openjdk-devel
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $PATH:$JAVA_HOME/bin

# install spark
RUN curl -s https://downloads.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_PROFILE.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-$SPARK_VERSION-bin-hadoop$HADOOP_PROFILE spark

# update boot script
COPY entrypoint.sh /usr/share/entrypoint.sh
RUN chown root.root /usr/share/entrypoint.sh
RUN chmod 700 /usr/share/entrypoint.sh

#spark
EXPOSE 8080 7077 8888 8081

ENTRYPOINT ["/usr/share/entrypoint.sh"]