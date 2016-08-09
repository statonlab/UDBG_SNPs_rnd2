#!/bin/bash
# run freebayes using the 3n's
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 3 \
06_3n.bam \
> 07_3n.vcf >& 07_3n_freebayes.vcf
