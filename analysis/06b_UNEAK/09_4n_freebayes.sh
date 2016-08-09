#!/bin/bash
# run freebayes using the 4n's along with the priors we generated from running the UDBGs
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 4 \
-@ 08_all.vcf \
06_4n.bam \
> 09_4n.vcf >& 09_4n_freebayes.vcf
