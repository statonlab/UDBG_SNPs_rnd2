#!/bin/bash
# create tag count paired output
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -UTagCountToTagPairPlugin \
–e 0.03 \
-o ./tagPair/UNEAK.tp \
-i ./tagCounts/merged.cnt \
-endPlugin -runfork1
