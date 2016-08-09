#!/bin/bash
# merge duplicate snps in the vcf file again
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx50G -fork1 -MergeDuplicateSNP_vcf_Plugin \
-i ./vcfMerge/MergeTBT.c1 \
-o ./vcf/1.taxamerged.vcf \
-ak 3 \
-endPlugin -runfork1
