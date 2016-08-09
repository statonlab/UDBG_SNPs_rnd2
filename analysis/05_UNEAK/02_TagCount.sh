#!/bin/bash
#Usage is as follows:
# -i  Input directory containing FASTQ files in text or gzipped text.
#     NOTE: Directory will be searched recursively and should
#     be written WITHOUT a slash after its name.
#
# -k  Key file listing barcodes distinguishing the samples
# -e  Enzyme used to create the GBS library, if it differs from the one listed in the key file.
# -s  Max good reads per lane. (Optional. Default is 300,000,000).
# -c  Minimum tag count (default is 1).
# -o  Output directory to contain .cnt files (one per FASTQ file, defaults to input directory).
# -s 10000000 \
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx12G -fork1 -FastqToTagCountPlugin \
-i Illumina \
-k key/keyfile.txt \
-e ApeKI \
-s 300000000 \
-c 1 \
-o ./tagCounts \
-endPlugin -runfork1
