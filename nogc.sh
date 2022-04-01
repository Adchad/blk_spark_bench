#!/bin/bash
export JAVA_HOME="/home/adam/jdk11u/build/linux-x86_64-normal-server-release/images/jdk"


if [ "$1" = "noblk" ]; then
	$JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx8g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 
	total_time=$(grep "Time:" output | grep -o "[0-9]\+")
	printf "%s\n" $total_time
else
	if [ "$1" = "blk" ]; then
		systemd-run --scope -p MemoryHigh="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx8g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 
		total_time=$(grep "Time:" output | grep -o "[0-9]\+")
		printf "%s\n" $total_time

	else
		if [ "$1" = "blklimit" ]; then
			systemd-run --scope -p MemoryLimit="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC  -Xmx8g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 
			total_time=$(grep "Time:" output | grep -o "[0-9]\+" )
			printf "%s\n" $total_time

		else
			numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -XX:+UnlockExperimentalVMOptions -XX:+UseEpsilonGC -Xmx8g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 
			total_time=$(grep "Time:" output | grep -o "[0-9]\+" )
			printf "%s\n" $total_time
		fi

	fi
fi
