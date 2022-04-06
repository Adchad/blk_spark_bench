#!/bin/bash
#script to know what the Resident Set size of the jvm is relative to the Garbage collector selected

run(){
	$JAVA_HOME/bin/java -cp /home/adam/Spark_benchmark/spark_blk/conf/:/home/adam/Spark_benchmark/spark_blk/jars/* "$1" -Xmx16g org.apache.spark.deploy.SparkSubmit --master local[*] --class WordCount_dataset /home/adam/Spark_benchmark/spark_run/run.jar enwik"$2" > /dev/null 2>&1 & 

	pid=$!
	while kill -0 $pid >/dev/null 2>&1; do
		ps -q "$pid" -o rss= > /tmp/rss
		sleep 1
	done
	kilo=$(tail -n 1 /tmp/rss)
	giga=$(echo "scale=2;$kilo/1000000" | bc)
	printf "%s" $giga
}


for i in 5 9; do 
	printf "%d00," $i
	run "-XX:+UseParallelGC" $i
	sleep 1
	printf ","
	run "-XX:+UseG1GC" $i 
	sleep 1
	printf ","
	run "-XX:+UseConcMarkSweepGC" $i
	sleep 1
	printf ","
	run "-XX:+UseSerialGC" $i
	printf "\n"
	sleep 1
done
