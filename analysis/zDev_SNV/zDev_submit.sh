#!/bin/bash
# small script to submit scripts to newton
for f in `ls splits.*`
do
echo "#$ -N $f
#$ -q medium*
#$ -cwd
#$ -o ./out.$f.o.txt
#$ -e ./out.$f.e.txt
./zDev_SNV_pooled.py \
--i $f \
--o out.$f.tsv" > job.ogs
qsub job.ogs
rm -f job.ogs
done
