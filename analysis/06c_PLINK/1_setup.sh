#!/bin/bash
# create a link for our vcf results from 06b_UNEAK
ln -s ../06b_UNEAK/12_all.vcf ./
# we need to fix some of the weird naming artifacts from combining in GATK and also change the UNEAK_tag_genome to 1 so it can be processed by plink
sed 's/\.variant2//g' 12_all.vcf | sed 's/\.variant3//g' | sed 's/\.variant//g' | sed 's/UNEAK_tag_genome/1/g' > 12_all_fix.vcf
