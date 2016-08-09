#!/bin/bash
# Realign SNPs using GATK after converting sam output to bam
for f in `ls *.sam`
do
lib=$(echo $f | cut -d '.' -f 1)

echo "#$ -N $lib.05
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/$lib.05.ogs_output.txt
#$ -e ./ogs_output/$lib.05.ogs_error.txt
#$ -l mem=4g
module load samtools
samtools view -bT 02_UNEAK_genome.fasta -o $lib.bam $f
samtools sort $lib.bam > $lib.sort.bam
samtools index $lib.sort.bam
module load java/jdk8u5
java -jar /lustre/projects/staton/software/picard-tools-2.1.0/picard.jar \
AddOrReplaceReadGroups \
I=$lib.sort.bam \
O=05_$lib.head.bam \
RGSM=${lib} \
RGLB=${lib} \
RGPL=illumina \
RGPU=NB500947:110:HWTWGBGXX:1:11101: \
RGID=${lib}
samtools index 05_$lib.head.bam" > job.ogs
qsub job.ogs
rm -f job.ogs
done
