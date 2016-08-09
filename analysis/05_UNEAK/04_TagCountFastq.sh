#!/bin/bash
# convert tag count to fastq
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -TagCountToFastqPlugin –c 3 \
-o ./tagCounts/merged.fastq \
-i ./tagCounts/merged.cnt \
-endPlugin -runfork1
