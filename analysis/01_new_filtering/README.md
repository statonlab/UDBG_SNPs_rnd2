Objective is to get a look at the vcf files generated by Cornell and assess how to move forward.
####unzip the compressed file and put it here
```
gunzip -c ../../raw_data/distribute/all.filtered.recode.vcf.gz > all.filtered.recode.vcf
```
---
####create plots of the vcfstats file
```
/lustre/projects/staton/software/bcftools-1.2/plot-vcfstats -p plot all.filtered.recode.vchk
```
---
