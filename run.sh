#!/bin/bash
export JAVA_HOME="/home/adam/jdk11u/build/linux-x86_64-normal-server-release/images/jdk"


if [ "$1" = "noblk" ]; then
	spark_noblk/bin/spark-submit --class WordCount --master local[*] spark_run/run.jar > output 2>&1 ; grep "Time:" output 
else
	if [ "$1" = "blk" ]; then
		systemd-run --scope -p MemoryHigh="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 ; grep "Time:" output
	else
		systemd-run --scope -p MemoryLimit="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 ; grep "Time:" output
	fi
fi
