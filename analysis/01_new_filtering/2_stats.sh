#!/bin/bash
#/lustre/projects/staton/software/bcftools-1.2/bcftools stats all.filtered.recode.vcf > all.filtered.recode.vchk
/lustre/projects/staton/software/bcftools-1.2/plot-vcfstats -p plot all.filtered.recode.vchk
