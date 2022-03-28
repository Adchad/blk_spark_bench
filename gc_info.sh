#!/bin/bash
export JAVA_HOME="/home/adam/jdk11u/build/linux-x86_64-normal-server-release/images/jdk"


if [ "$1" = "noblk" ]; then
	$JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -Xlog:gc org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 ; grep "\[gc\]" output | grep "Pause" | grep -o "[0-9]\+,[0-9]\+ms" | grep -o "[0-9]\+,[0-9]\+" | sed -e "s/,/./g"  | paste -s -d+  | bc | xargs printf "GC Pause Time : %sms\n" ; grep "Time" output 
else
	if [ "$1" = "blk" ]; then
		systemd-run --scope -p MemoryHigh="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -Xlog:gc org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 ; grep "\[gc\]" output  | grep "Pause" | grep -o "[0-9]\+,[0-9]\+ms" | grep -o "[0-9]\+,[0-9]\+" | sed -e "s/,/./g"  | paste -s -d+  | bc | xargs printf "GC Pause Time : %sms\t" ; grep "Time" output 

	else
		systemd-run --scope -p MemoryLimit="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -Xlog:gc org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount /home/adam/Spark_benchmark/spark_run/run.jar > output 2>&1 ; grep "\[gc\]" output  | grep "Pause" | grep -o "[0-9]\+,[0-9]\+ms" | grep -o "[0-9]\+,[0-9]\+" | sed -e "s/,/./g"  | paste -s -d+  | bc | xargs printf "GC Pause Time : %sms\t" ; grep "Time" output 

	fi
fi
