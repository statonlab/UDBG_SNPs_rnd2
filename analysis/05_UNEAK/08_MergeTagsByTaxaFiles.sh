#!/bin/bash
# merge the taxa files 
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx12G -fork1 -MergeTagsByTaxaFilesPlugin \
-s 300000000 \
-o ./MergeTBT/UNEAK.tbt.byte \
-i ./TBT \
-endPlugin -runfork1
