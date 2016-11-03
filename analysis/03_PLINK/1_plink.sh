#!/bin/bash
# create the plink genome file
/lustre/projects/staton/software/plink-1.07-x86_64/plink \
--file 4_udbg --genome --noweb
# use plink to generate the mds plot (cluster on 4)
/lustre/projects/staton/software/plink-1.07-x86_64/plink \
--file 4_udbg --read-genome plink.genome --mds-plot 4 --noweb
