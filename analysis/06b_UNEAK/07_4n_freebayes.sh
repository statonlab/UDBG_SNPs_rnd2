#!/bin/bash
# run freebayes using the 4n's
/lustre/projects/staton/software/freebayes_1.0.2-15/bin/freebayes \
-f 02_UNEAK_genome.fasta \
-p 4 \
06_4n.bam \
> 07_4n.vcf >& 07_4n_freebayes.vcf
