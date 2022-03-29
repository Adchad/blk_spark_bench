#!/bin/bash

for i in 512 768 1024 1280 1536 1792 2048; do
	rmmod fakeblk
	insmod /home/adam/fakeblk/brd/fakeblk.ko
	printf "%sM," $i
	./gc_info.sh blklimit $i $1
done

printf "NoLimit,"
./gc_info.sh nolimit 0 $1

printf "NoSwap,"
./gc_info.sh noblk 0 $1

