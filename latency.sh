#!/bin/bash

run(){
	for i in $(seq 0 100 1000); do
		rmmod fakeblk
		insmod /home/adam/fakeblk/latency/fakeblk.ko latency=$i
		printf "%s," $i
		./gc_info.sh blklimit 1536 $1
	done
}

rm /tmp/latencyg1
rm /tmp/latencycms
run "-XX:+UseG1GC" >> /tmp/latencyg1
run "-XX:+UseConcMarkSweep" >> /tmp/latencycms

