#!/bin/bash
# combine the vcf files from our results in freebayes using GATK
java -jar /lustre/projects/staton/software/GenomeAnalysisTK-3.5-0/GenomeAnalysisTK.jar \
-T CombineVariants \
-R 02_UNEAK_genome.fasta \
--variant 07_3n_freebayes.vcf \
--variant 07_2n_freebayes.vcf \
--variant 07_4n_freebayes.vcf \
-o 08_all.vcf \
-genotypeMergeOptions UNIQUIFY
