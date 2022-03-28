#!/bin/bash

for i in 500 800 1000 1200 1500; do
	rmmod fakeblk
	insmod /home/adam/fakeblk/brd/fakeblk.ko

	printf "%sM," $i
	./gc_info.sh blklimit $i
done

printf "NoSwap,"
./gc_info.sh noblk

