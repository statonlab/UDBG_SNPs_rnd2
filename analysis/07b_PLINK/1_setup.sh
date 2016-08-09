#!/bin/bash
# create a link to the results vcf file
ln -s ../7_UNEAK/18_all.vcf ./
# replace the UNEAK_tag_genome chromosome names with 1 so it can be processed by plink
sed 's/UNEAK_tag_genome/1/g' 18_all.vcf > 18_all_fix.vcf
