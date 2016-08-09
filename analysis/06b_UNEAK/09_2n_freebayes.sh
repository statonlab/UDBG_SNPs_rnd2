#!/bin/bash
# run freebayes using the 2n's along with the priors we generated from running the UDBGs
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 2 \
-@ 08_all.vcf \
06_2n.bam \
> 09_2n.vcf >& 09_2n_freebayes.vcf
