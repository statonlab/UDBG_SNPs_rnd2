#!/bin/bash
# Could you filter for SNPs where we have at least 5 reads in at least 80 individuals? % of sites missing information, 80/96 = 0.83333, max-missing 0.84, minimum allowed depth 5, minDP 5
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
--remove-indv blank \
--max-missing 0.84 \
--minDP 5 \
--plink
