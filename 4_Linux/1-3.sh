#!/bin/bash

mem=($(free -m | awk '/Mem:/ {print $4}'))
echo "${mem} MB"