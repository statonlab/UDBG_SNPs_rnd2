#!/bin/bash
# convert tag count to topm.bin format
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -UExportTagPairPlugin \
-d 100 \
-m ./topm/UNEAK.topm.bin \
-i ./tagPair/UNEAK.tp \
-endPlugin -runfork1
#-t ./topm/UNEAK.topm.txt \
