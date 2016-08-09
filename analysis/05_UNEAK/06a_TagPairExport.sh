#!/bin/bash
# export tagpairs to UNEAK.topm format
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -UExportTagPairPlugin \
-d 100 \
-t ./topm/UNEAK.topm.txt \
-i ./tagPair/UNEAK.tp \
-endPlugin -runfork1
