#!/bin/sh
find $1 -name '*.gz' -exec gzip -d {} \; && grep -rI -B 10 -A 50 $2 $1
