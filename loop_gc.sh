#!/bin/bash

for i in 500 800 1000 1200 1500; do
	rmmod fakeblk
	insmod /home/adam/fakeblk/brd/fakeblk.ko

	printf "Size: %sM, " $i
	./gc_info.sh blklimit $i
done

printf "No Block, "
./gc_info.sh noblk

