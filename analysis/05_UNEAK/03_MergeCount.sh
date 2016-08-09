#!/bin/bash
# run merge tag count plugin
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -MergeMultipleTagCountPlugin \
-i ./tagCounts \
-o ./tagCounts/merged.cnt \
-c 3 \
-endPlugin -runfork1
