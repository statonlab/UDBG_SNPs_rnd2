#!/bin/bash
# convert fastq to tag counts
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx12G -fork1 -FastqToTagCountPlugin \
-i Illumina \
-k key/keyfile.txt \
-e ApeKI \
-s 300000000 \
-c 1 \
-o ./tagCounts \
-endPlugin -runfork1
