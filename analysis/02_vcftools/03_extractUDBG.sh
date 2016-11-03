#!/bin/bash
# just want to creat a list of all the species start by getting first ten lines...
head /lustre/projects/staton/projects/Brosnan/UDBG_SNPs_rnd1/analysis/2_vcftools/3_out/out.recode.vcf |\
# then grab just the tenth line
tail -n1 |\
# seperate the tabs into individual lines
sed 's/\t/\n/g' |\
# keep only lines that contain :
grep ":" |\
# now split them by the :
cut -f 1 -d ':' |\
# need to replace some text to make it cleaner
sed 's/\(.*\)/\L\1/' |\
# add the --indv tag (we can use this to copy and paste into a vcftools command)
sed 's/^/--indv /g' |\
# add a \ at the end so they are all part of the same "line"
sed 's/$/ \\/g'
