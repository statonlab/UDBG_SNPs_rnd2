Objective is to create various filterings of the Cornell SNPs and generate the files needed to create MDS plots in R.
####unzip important files needed for processing
```
gunzip -c ../../raw_data/distribute/all.vcf.gz > all.vcf
gunzip -c ../../raw_data/distribute/all.taxamerged.vcf.gz > all.taxamerged.vcf
gunzip -c ../../raw_data/distribute/all.taxamerged.filtered.recode.vcf.gz > all.taxamerged.filtered.recode.vcf
```
---
####Could you filter for SNPs where we have at least 5 reads in at least 80 individuals? % of sites missing information, 80/96 = 0.83333, max-missing 0.84, minimum allowed depth 5, minDP 5
```
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
--remove-indv blank \
--max-missing 0.84 \
--minDP 5 \
--plink
```
---
####just want to creat a list of all the species start by getting first ten lines...
```
head /lustre/projects/staton/projects/Brosnan/UDBG_SNPs_rnd1/analysis/2_vcftools/3_out/out.recode.vcf |\
```
####then grab just the tenth line
```
tail -n1 |\
```
####seperate the tabs into individual lines
```
sed 's/\t/\n/g' |\
```
####keep only lines that contain :
```
grep ":" |\
```
####now split them by the :
```
cut -f 1 -d ':' |\
```
####need to replace some text to make it cleaner
```
sed 's/\(.*\)/\L\1/' |\
```
####add the --indv tag (we can use this to copy and paste into a vcftools command)
```
sed 's/^/--indv /g' |\
```
####add a \ at the end so they are all part of the same "line"
```
sed 's/$/ \\/g'
```
---
####max-missing 0.90, minimum allowed depth 5, minDP 5
```
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
```
####run analysis on only these individuals...
```
--indv ch1 \
--indv ch2 \
--indv ch3 \
--indv ch4 \
--indv ch5 \
--indv ch6 \
--indv mv1 \
--indv mv2 \
--indv mv3 \
--indv mv4 \
--indv mv5 \
--indv td1 \
--indv td2 \
--indv td3 \
--indv td4 \
--indv td5 \
--indv td6 \
--indv te1 \
--indv te2 \
--indv te3 \
--indv te4 \
--indv te5 \
--indv te6 \
--indv tg1 \
--indv tg2 \
--indv tg3 \
--indv tg4 \
--indv tg5 \
--indv tg6 \
--max-missing 0.90 \
--minDP 5 \
--out 4_udbg \
--plink
```
---
####same as 04 but let's generate a vcf file instead this time..
```
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
--indv ch1 \
--indv ch2 \
--indv ch3 \
--indv ch4 \
--indv ch5 \
--indv ch6 \
--indv mv1 \
--indv mv2 \
--indv mv3 \
--indv mv4 \
--indv mv5 \
--indv td1 \
--indv td2 \
--indv td3 \
--indv td4 \
--indv td5 \
--indv td6 \
--indv te1 \
--indv te2 \
--indv te3 \
--indv te4 \
--indv te5 \
--indv te6 \
--indv tg1 \
--indv tg2 \
--indv tg3 \
--indv tg4 \
--indv tg5 \
--indv tg6 \
--max-missing 0.90 \
--out 5_udbg \
--recode
```
---
####let's drop max-missing to 0.80 and increase minDP to 20 (output vcf)
```
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
--indv ch1 \
--indv ch2 \
--indv ch3 \
--indv ch4 \
--indv ch5 \
--indv ch6 \
--indv mv1 \
--indv mv2 \
--indv mv3 \
--indv mv4 \
--indv mv5 \
--indv td1 \
--indv td2 \
--indv td3 \
--indv td4 \
--indv td5 \
--indv td6 \
--indv te1 \
--indv te2 \
--indv te3 \
--indv te4 \
--indv te5 \
--indv te6 \
--indv tg1 \
--indv tg2 \
--indv tg3 \
--indv tg4 \
--indv tg5 \
--indv tg6 \
--max-missing 0.80 \
--minDP 20 \
--out 6_udbg \
--recode
```
---
####drop minDP to 10 from 20
```
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
--indv ch1 \
--indv ch2 \
--indv ch3 \
--indv ch4 \
--indv ch5 \
--indv ch6 \
--indv mv1 \
--indv mv2 \
--indv mv3 \
--indv mv4 \
--indv mv5 \
--indv td1 \
--indv td2 \
--indv td3 \
--indv td4 \
--indv td5 \
--indv td6 \
--indv te1 \
--indv te2 \
--indv te3 \
--indv te4 \
--indv te5 \
--indv te6 \
--indv tg1 \
--indv tg2 \
--indv tg3 \
--indv tg4 \
--indv tg5 \
--indv tg6 \
--max-missing 0.80 \
--minDP 10 \
--out 7_udbg \
--recode
```
---
####generate a plink for 10_all93
```
/lustre/projects/staton/software/vcftools_0.1.12a/bin/vcftools \
--vcf all.taxamerged.vcf \
--max-missing 0.90 \
--minDP 5 \
--out 10_all93 \
--plink
```
---
####create a plink mds plot for all93
```
/lustre/projects/staton/software/plink-1.07-x86_64/plink \
--file 10_all93 --genome --noweb
/lustre/projects/staton/software/plink-1.07-x86_64/plink \
--file 10_all93 --read-genome plink.genome --mds-plot 4 --noweb
```
---
