####6b_UNEAK analysis
an alternative approach begins with extracting tagpairs earlier in the UNEAK pipeline (directly after Tag pair counting was performed),
this is continued from 6_UNEAK 06b_TagPairExport.sh && x0_UNEAK.top.bin.PEAK.sh, see the 01_setup.sh in order to determine from  where
the 01_UNEAK.topm.tagpairs.txt file was linked.
####create a link to our topm.tagpairs.txt from 6_UNEAK
```
ln -s ../6_UNEAK/x0_UNEAK.topm.tagpairs.txt ./01_UNEAK.topm.tagpairs.txt
```
---
####create a pseudo genome by joining all tags by poly-A strings of 10 ntds. This is necessary to prevent a segfault in freebayes
```
if [ "0"=="0" ]
then
	echo ">UNEAK_tag_genome"
	sed '1d' 01_UNEAK.topm.tagpairs.txt |\
        sed '2~2d' |\
	cut -f 1 |\
	awk '/^..*$/{ print $0 "AAAAAAAAAAAAAAAAAAAA" ;next}{print}'
fi > 02_UNEAK_genome.fasta
module load java/jdk8u5
java -jar /lustre/projects/staton/software/picard-tools-2.1.0/picard.jar \
CreateSequenceDictionary \
R=02_UNEAK_genome.fasta \
O=02_UNEAK_genome.dict
```
---
####create a bowtie2 database
```
/lustre/projects/staton/software/bowtie2-2.2.7/bowtie2-build \
02_UNEAK_genome.fasta 02_UNEAK_genome
```
---
####create output dir for newton
```
mkdir ogs_output
```
####run bowtie2 on all of our trim.fastq files 
```
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
```
---
####Realign SNPs using GATK after converting sam output to bam
```
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
```
---
####use samtools to merge 2n's into one file
```
module load samtools
samtools merge 06_2n.bam 05_DA1.head.bam 05_DA2.head.bam 05_DA3.head.bam 05_DB1.head.bam 05_DB2.head.bam 05_DB3.head.bam
samtools index 06_2n.bam
```
---
####use samtools to merge 3n's into one file
```
module load samtools
samtools merge 06_3n.bam 05_TG1.head.bam 05_TG2.head.bam 05_TG3.head.bam 05_TG4.head.bam 05_TG5.head.bam 05_TG6.head.bam 05_TD1.head.bam 05_TD2.head.bam 05_TD3.head.bam 05_TD4.head.bam 05_TD5.head.bam 05_TD6.head.bam 05_TE1.head.bam 05_TE2.head.bam 05_TE3.head.bam 05_TE4.head.bam 05_TE5.head.bam 05_TE6.head.bam 05_MV1.head.bam 05_MV2.head.bam 05_MV3.head.bam 05_MV4.head.bam 05_MV5.head.bam 05_MV6.head.bam 05_CH1.head.bam 05_CH2.head.bam 05_CH3.head.bam 05_CH4.head.bam 05_CH5.head.bam 05_CH6.head.bam 05_TW1.head.bam 05_TW2.head.bam 05_TW3.head.bam 05_TW4.head.bam 05_TW5.head.bam 05_TW6.head.bam 05_S1.head.bam 05_S2.head.bam 05_S3.head.bam 05_S4.head.bam 05_S5.head.bam 05_S6.head.bam 05_S7.head.bam 05_S8.head.bam 05_S9.head.bam 05_S10.head.bam 05_S11.head.bam 05_S12.head.bam 05_S13.head.bam 05_S14.head.bam 05_S15.head.bam 05_S16.head.bam 05_S17.head.bam 05_S18.head.bam 05_S19.head.bam 05_S20.head.bam 05_S21.head.bam 05_S22.head.bam 05_S23.head.bam 05_S24.head.bam 05_S25.head.bam 05_S26.head.bam 05_S27.head.bam 05_S28.head.bam 05_S29.head.bam 05_S30.head.bam 05_S31.head.bam 05_S32.head.bam 05_S33.head.bam 05_S34.head.bam 05_S35.head.bam 05_S36.head.bam 05_S37.head.bam 05_S38.head.bam 05_S39.head.bam 05_S40.head.bam 05_S41.head.bam 05_S42.head.bam 05_S43.head.bam 05_S44.head.bam 05_S45.head.bam 05_S46.head.bam 05_S47.head.bam
samtools index 06_3n.bam
```
---
####use samtools to merge 4n's into one file
```
module load samtools
samtools merge 06_4n.bam 05_TA1.head.bam 05_TA2.head.bam 05_TA3.head.bam 05_TB1.head.bam 05_TB2.head.bam 05_TB3.head.bam
samtools index 06_4n.bam
```
---
####run freebayes using the 2n's
```
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 2 \
06_2n.bam \
> 07_2n.vcf >& 07_2n_freebayes.vcf
```
---
####run freebayes using the 3n's
```
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 3 \
06_3n.bam \
> 07_3n.vcf >& 07_3n_freebayes.vcf
```
---
####run freebayes using the 4n's
```
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 4 \
06_4n.bam \
> 07_4n.vcf >& 07_4n_freebayes.vcf
```
---
####combine the vcf files from our results in freebayes using GATK
```
java -jar /lustre/projects/staton/software/GenomeAnalysisTK-3.5-0/GenomeAnalysisTK.jar \
-T CombineVariants \
-R 02_UNEAK_genome.fasta \
--variant 07_3n_freebayes.vcf \
--variant 07_2n_freebayes.vcf \
--variant 07_4n_freebayes.vcf \
-o 08_all.vcf \
-genotypeMergeOptions UNIQUIFY
```
---
####run freebayes using the 2n's along with the priors we generated from running the UDBGs
```
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 2 \
-@ 08_all.vcf \
06_2n.bam \
> 09_2n.vcf >& 09_2n_freebayes.vcf
```
---
####run freebayes using the 3n's along with the priors we generated from running the UDBGs
```
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 3 \
-@ 08_all.vcf \
06_3n.bam \
> 09_3n.vcf >& 09_3n_freebayes.vcf
```
---
####run freebayes using the 4n's along with the priors we generated from running the UDBGs
```
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 4 \
-@ 08_all.vcf \
06_4n.bam \
> 09_4n.vcf >& 09_4n_freebayes.vcf
```
---
####xDev_convert2n.py converts the 3n and 4n into a 2n-like format so it can be processed by plink
```
module load python/2.7.11
../xDev_SNV/xDev_convert2n.py --i 07_3n_freebayes.vcf > 07_3n_2n_freebayes.vcf &
../xDev_SNV/xDev_convert2n.py --i 07_4n_freebayes.vcf > 07_4n_2n_freebayes.vcf &
```
---
####combine our 2n-like 3n + 4n's as well as our true 2n's into a single file (this is for running plink)
```
java -jar /lustre/projects/staton/software/GenomeAnalysisTK-3.5-0/GenomeAnalysisTK.jar \
-T CombineVariants \
-R 02_UNEAK_genome.fasta \
--variant 07_3n_2n_freebayes.vcf \
--variant 07_2n_freebayes.vcf \
--variant 07_4n_2n_freebayes.vcf \
-o 12_all.vcf \
-genotypeMergeOptions UNIQUIFY
```
---
