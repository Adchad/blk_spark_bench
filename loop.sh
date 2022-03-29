#!/bin/bash

for i in 512 768 1024 1280 1536 1792 2048; do
	rmmod fakeblk
	insmod /home/adam/fakeblk/brd/fakeblk.ko

	printf "Size: %sM, " $i
	./nogc.sh blklimit $i
done

printf "No Block, "
./nogc.sh noblk

