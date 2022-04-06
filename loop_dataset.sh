#!/bin/bash


run(){
	for i in 1024 1536 2048 2560 3072 3584 4096; do
		rmmod fakeblk
		insmod /home/adam/fakeblk/brd/fakeblk.ko
		printf "%sM," $i
		./gc_dataset.sh blklimit $i $1 $2
	done
	
	printf "NoLimit,"
	./gc_dataset.sh nolimit 0 $1 $2
	
	printf "NoSwap,"
	./gc_dataset.sh noblk 0 $1 $2
}

rm -rf /home/adam/perf_dataset

mkdir /home/adam/perf_dataset

run "-XX:+UseG1GC" 5 >/home/adam/perf_dataset/perf_pc_G1
run "-XX:+UseConcMarkSweepGC" 9 > /home/adam/perf_dataset/perf_pc_CMS
