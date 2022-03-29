#!/bin/bash
rm -rf /home/adam/perf

mkdir /home/adam/perf

./loop_choose_GC.sh "-XX:+UseG1GC" > /home/adam/perf/perf_pc_G1
./loop_choose_GC.sh "-XX:+UseParallelGC" > /home/adam/perf/perf_pc_PS
./loop_choose_GC.sh "-XX:+UseConcMarkSweepGC"> /home/adam/perf/perf_pc_CMS
