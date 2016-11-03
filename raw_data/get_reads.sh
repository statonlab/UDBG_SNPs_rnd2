#!/bin/bash
for f in `ls *.fastq`
do
echo $f
grep "^@" $f | wc -l
done | paste - -
