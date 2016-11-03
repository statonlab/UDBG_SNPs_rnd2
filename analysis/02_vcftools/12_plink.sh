#!/bin/bash
# create a plink mds plot for all93
/lustre/projects/staton/software/plink-1.07-x86_64/plink \
--file 10_all93 --genome --noweb
/lustre/projects/staton/software/plink-1.07-x86_64/plink \
--file 10_all93 --read-genome plink.genome --mds-plot 4 --noweb
