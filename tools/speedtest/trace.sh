#!/bin/bash
for file in `ls | grep ip`
do
  cat $file | while read line
  do
    echo "Traceroute to $line :" >> trace.log
    ./besttrace -n -q 1 $line | grep -v 'traceroute to' | awk '{print $7$8$9" ("$5") ["$3$4"] "}' | tee -a trace.log
  done
done
