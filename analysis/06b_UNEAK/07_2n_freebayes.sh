#!/bin/bash
# run freebayes using the 2n's
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 2 \
06_2n.bam \
> 07_2n.vcf >& 07_2n_freebayes.vcf
