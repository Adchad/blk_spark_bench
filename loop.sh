#!/bin/bash

for i in 500 800 1000 1200 1500; do
	rmmod fakeblk
	insmod /home/adam/fakeblk/brd/fakeblk.ko

	printf "Size: %sM, " $i
	./run.sh blklimit $i
done

printf "No Block, "
./run.sh noblk

