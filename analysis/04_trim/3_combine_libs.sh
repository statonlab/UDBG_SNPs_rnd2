#!/bin/bash
# combine libraries
for f in {"CH","TD","TE","TG","TW"}
do
cat ${f}1.trim.fastq ${f}2.trim.fastq ${f}3.trim.fastq ${f}4.trim.fastq ${f}5.trim.fastq ${f}6.trim.fastq > ${f}.combined.fastq
done
f=MV
cat ${f}1.trim.fastq ${f}2.trim.fastq ${f}3.trim.fastq ${f}4.trim.fastq ${f}5.trim.fastq > ${f}.combined.fastq
for f in {"TA","TB"}
do
cat ${f}1.trim.fastq ${f}2.trim.fastq ${f}3.trim.fastq > ${f}.combined.fastq
done
for f in {"DA","DB"}
do
cat ${f}1.trim.fastq ${f}2.trim.fastq ${f}3.trim.fastq > ${f}.combined.fastq
done
for s in {1..47}
do
# this is just done for convience of referencing 
ln -s S${s}.trim.fastq ./S${s}.combined.fastq
done
rm -f S28.combined.fastq
