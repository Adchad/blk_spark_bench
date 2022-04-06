#!/bin/bash

run(){
	./gc_info.sh blklimit 1536 $1 >/dev/null &
	sleep 1
	pid=$($JAVA_HOME/bin/jps  -lvm | grep "org.apache" | grep -o "[0-9]\+ ")
	i=0
	while kill -0 $pid >/dev/null 2>&1; do
		/home/adam/jdk11u/build/linux-x86_64-normal-server-release/images/jdk/bin/jhsdb jmap --heap --pid $pid > /tmp/jhsdb_output
		grep "used \+=" /tmp/jhsdb_output | grep -o "[0-9]\+.[0-9]\+MB" | grep -o "[0-9]\+.[0-9]\+" > /tmp/jhsdb_sizes
		
		printf "%d," $i
		let "i++"
		case $1 in 
			"-XX:+UseConcMarkSweepGC" | "-XX:+UseParallelGC")
				cat /tmp/jhsdb_sizes | paste -s -d+ | bc
				;;
			"-XX:+UseG1GC")
				cat /tmp/jhsdb_sizes | sort -n | tail -1
				;;

		esac
		sleep 1
	done
}


rm /tmp/g1heap
rm /tmp/cmsheap
rm /tmp/psheap
run "-XX:+UseG1GC" >> /tmp/g1heap
run "-XX:+UseConcMarkSweepGC" >> /tmp/cmsheap
run "-XX:+UseParallelGC" >> /tmp/psheap
