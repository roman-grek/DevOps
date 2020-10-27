#! /bin/bash

mem=$(df --block-size=1 | awk '$2 ~ /[0-9]+/ {sum += $2} END {print sum}')
echo "$mem bytes"