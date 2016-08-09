#!/bin/bash
# create output dir for newton
mkdir ogs_output

# run bowtie2 on all of our trim.fastq files 
for f in `ls ../8_trim/*.trim.fastq`
do
lib=`basename $f | sed 's/\.trim\.fastq//g'`
echo "#$ -N $lib.bt2
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/$lib.bt2.ogs_output.txt
#$ -e ./ogs_output/$lib.bt2.ogs_error.txt
/lustre/projects/staton/software/bowtie2-2.2.7/bowtie2 \
--very-sensitive-local \
-x 02_UNEAK_genome \
-U $f \
-S $lib.sam \
>& $lib.bt2.txt" > job.ogs
qsub job.ogs
rm -f job.ogs
done
