#!/bin/bash
# convert back to vcf again
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx50G -fork1 -tbt2vcfPlugin \
-i ./MergeTBT/UNEAK.tbt.byte \
-ak 3 \
-mnLCov 0 \
-m ./topm/UNEAK.topm.bin \
-mnMAF 0.01 \
-o ./vcfMerge/ \
-s 1 \
-e 1 \
-endPlugin -runfork1
