#!/bin/bash

# get list of all processes and count rows
lines=$(ps -aux | wc -l)
lines=$(( lines - 1 ))
echo $lines
