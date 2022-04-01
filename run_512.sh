#!/bin/bash

run(){
	rmmod fakeblk 
	insmod /home/adam/fakeblk/brd/fakeblk.ko
	bpftrace -e 'kprobe:brd_do_bvec {if(arg4==1){@writes = count();}else{@reads = count();}}' > bpf_output   &
	bpf_pid="$!"
	./gc_info.sh blklimit 2048 "$1" > /dev/null 2>&1
	kill -2 $bpf_pid
	sleep 1
	tac bpf_output | grep ":" | grep -o "[0-9]\+" | paste -s -d,
}

printf "PS,"
run -XX:+UseParallelGC
printf "G1,"
run -XX:+UseG1GC
printf "CMS,"
run -XX:+UseConcMarkSweepGC
