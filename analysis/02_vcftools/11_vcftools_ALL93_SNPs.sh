#!/bin/bash
# generate a plink for 10_all93
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
--max-missing 0.90 \
--minDP 5 \
--out 10_all93 \
--plink
