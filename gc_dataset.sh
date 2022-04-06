#!/bin/bash
export JAVA_HOME="/home/adam/jdk11u/build/linux-x86_64-normal-server-release/images/jdk"


if [ "$1" = "noblk" ]; then
	gc_time=$($JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -Xlog:gc "$3" -Xmx16g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount_dataset /home/adam/Spark_benchmark/spark_run/run.jar enwik"$4" > output 2>&1 ; grep "\[gc\]" output | grep "Pause" | grep -o "[0-9]\+,[0-9]\+ms" | grep -o "[0-9]\+,[0-9]\+" | sed -e "s/,/./g"  | paste -s -d+  | bc)
	total_time=$(grep "Time:" output | grep -o "[0-9]\+" )
	mut_time=$(echo "$total_time-$gc_time"| bc ) 
	printf "%s,%s\n" $mut_time $gc_time
else
	if [ "$1" = "blk" ]; then
		gc_time=$(systemd-run --scope -p MemoryHigh="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -Xlog:gc "$3" -Xmx16g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount_dataset /home/adam/Spark_benchmark/spark_run/run.jar enwik"$4" > output 2>&1 ; grep "\[gc\]" output  | grep "Pause" | grep -o "[0-9]\+,[0-9]\+ms" | grep -o "[0-9]\+,[0-9]\+" | sed -e "s/,/./g"  | paste -s -d+  | bc)
		total_time=$(grep "Time:" output | grep -o "[0-9]\+" )
		mut_time=$(echo "$total_time-$gc_time"| bc ) 
		printf "%s,%s\n" $mut_time $gc_time

	else
		if [ "$1" = "blklimit" ]; then
			gc_time=$(systemd-run --scope -p MemoryLimit="$2"M numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -Xlog:gc=debug "$3" -Xmx16g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount_dataset /home/adam/Spark_benchmark/spark_run/run.jar enwik"$4" > output 2>&1 ; grep "\[gc\]" output  | grep "Pause" | grep -o "[0-9]\+,[0-9]\+ms" | grep -o "[0-9]\+,[0-9]\+" | sed -e "s/,/./g"  | paste -s -d+  | bc  )
			total_time=$(grep "Time:" output | grep -o "[0-9]\+" )
			mut_time=$(echo "$total_time-$gc_time"| bc ) 
			printf "%s,%s\n" $mut_time $gc_time

		else
			gc_time=$(numactl --preferred=0 $JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* -XX:AllocateHeapAt=/dev/fakeblk -Xlog:gc "$3" -Xmx16g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount_dataset /home/adam/Spark_benchmark/spark_run/run.jar enwik"$4" > output 2>&1 ; grep "\[gc\]" output  | grep "Pause" | grep -o "[0-9]\+,[0-9]\+ms" | grep -o "[0-9]\+,[0-9]\+" | sed -e "s/,/./g"  | paste -s -d+  | bc  )
			total_time=$(grep "Time:" output | grep -o "[0-9]\+" )
			mut_time=$(echo "$total_time-$gc_time"| bc ) 
			printf "%s,%s\n" $mut_time $gc_time
		fi

	fi
fi
