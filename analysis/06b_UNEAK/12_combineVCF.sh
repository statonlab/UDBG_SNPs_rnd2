#!/bin/bash
# combine our 2n-like 3n + 4n's as well as our true 2n's into a single file (this is for running plink)
java -jar /lustre/projects/staton/software/GenomeAnalysisTK-3.5-0/GenomeAnalysisTK.jar \
-T CombineVariants \
-R 02_UNEAK_genome.fasta \
--variant 07_3n_2n_freebayes.vcf \
--variant 07_2n_freebayes.vcf \
--variant 07_4n_2n_freebayes.vcf \
-o 12_all.vcf \
-genotypeMergeOptions UNIQUIFY
