#!/bin/bash
# convert fastq data to TBT format
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -FastqToTBTPlugin \
-e ApeKI \
-y -t ./tagCounts/merged.cnt \
-c 1 \
-k ./key/keyfile.txt \
–m ./topm/UNEAK.topm.bin \
-o ./TBT \
-i ./Illumina \
-endPlugin -runfork1
