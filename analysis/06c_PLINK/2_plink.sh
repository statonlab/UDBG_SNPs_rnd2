#!/bin/bash
# have plink load the vcf file into a plink-useable format
/lustre/projects/staton/software/plink_1.9/plink \
--vcf 12_all_fix.vcf --make-bed --out ver1
# create the plink genome file
/lustre/projects/staton/software/plink_1.9/plink \
--bfile ver1 --genome --noweb
# use plink to generate the mds plot (cluster on 4)
/lustre/projects/staton/software/plink_1.9/plink \
--bfile ver1 --read-genome plink.genome --mds-plot 4 --cluster
