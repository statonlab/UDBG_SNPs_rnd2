#!/bin/bash
# merge duplicate snps in the vcf file
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx50G -fork1 -MergeDuplicateSNP_vcf_Plugin \
-i ./vcf/MergeTBT.c1 \
-o ./vcf/1.vcf \
-ak 3 \
-endPlugin -runfork1
