#!/bin/bash

/bin/bash /etc/bootstrap.sh

export JAVA_HOME=/usr/java/default
export PATH=${JAVA_HOME}/bin:${PATH}
export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar

cd /usr/local/hadoop

bin/hadoop fs -moveFromLocal /io/ io

bin/hadoop com.sun.tools.javac.Main WordCount.java

jar cf wc.jar WordCount*.class

bin/hadoop com.sun.tools.javac.Main BigramCount.java

jar cf bc.jar BigramCount*.class

echo "Running Word Count Example"

bin/hadoop jar bc.jar WordCount ./io/input ./io/output-wc

bin/hadoop fs -cat ./io/output-wc/part-r-00000

echo "Running Bigram Count"

bin/hadoop jar bc.jar BigramCount ./io/input ./io/output-bc

bin/hadoop fs -cat ./io/output-bc/part-r-00000