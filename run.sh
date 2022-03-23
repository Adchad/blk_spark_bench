#!/bin/bash

if [ "$1" = "noblk" ]; then
	spark_noblk/bin/spark-submit --class WordCount --master local[*] spark_run/run.jar > output 2>&1 ; grep "Time:" output 
else
	systemd-run --scope -p MemoryLimit=1G numactl --preferred=0 spark_blk/bin/spark-submit --class WordCount --master local[*] spark_run/run.jar > output 2>&1 ; grep "Time:" output
fi
