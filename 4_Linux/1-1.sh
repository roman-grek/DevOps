#!/bin/bash

# get list of all processes and count rows
lines=$(ps -aux | wc -l)
# first line is the head of the table - we don't need to count it
lines=$(( lines - 1 ))
echo $lines
