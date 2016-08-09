#!/bin/bash
# run freebayes using the 3n's along with the priors we generated from running the UDBGs
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 3 \
-@ 08_all.vcf \
06_3n.bam \
> 09_3n.vcf >& 09_3n_freebayes.vcf
