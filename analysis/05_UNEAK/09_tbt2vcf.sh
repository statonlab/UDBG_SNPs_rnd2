#!/bin/bash
# convert tbt to vcf fomrat
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx12G -fork1 -tbt2vcfPlugin \
-i ./MergeTBT/UNEAK.tbt.byte \
-ak 3 \
-mnLCov 0 \
-m ./topm/UNEAK.topm.bin \
-mnMAF 0.01 \
-o ./vcf/ \
-s 1 \
-e 1 \
-endPlugin -runfork1
