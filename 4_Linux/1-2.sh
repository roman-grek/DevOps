#!/bin/bash

# mpstat shows all cpus, args 1 1 tell it to print output every second and stop after 1st second
# awk finds row where 'all' is in the 2nd column and prints 3rd column (cpu usage) 
loads=($(mpstat -P ALL 1 1 | awk '$2 ~ /all/ {print $3}'))
echo "${loads}%"