#!/bin/bash

for i in 1024 1536 2048 2560 3072 3584 4096; do
	rmmod fakeblk
	insmod /home/adam/fakeblk/brd/fakeblk.ko
	printf "%sM," $i
	./gc_info.sh blklimit $i $1
done

printf "NoLimit,"
./gc_info.sh nolimit 0 $1

printf "NoSwap,"
./gc_info.sh noblk 0 $1

