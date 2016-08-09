####create a link to the results vcf file
```
ln -s ../7_UNEAK/18_all.vcf ./
```
####replace the UNEAK_tag_genome chromosome names with 1 so it can be processed by plink
```
sed 's/UNEAK_tag_genome/1/g' 18_all.vcf > 18_all_fix.vcf
```
---
####have plink load the vcf file into a plink-useable format
```
/lustre/projects/staton/software/plink_1.9/plink \
--vcf 18_all_fix.vcf --make-bed --out ver1
```
####create the plink genome file
```
/lustre/projects/staton/software/plink_1.9/plink \
--bfile ver1 --genome --noweb
```
####use plink to generate the mds plot (cluster on 4)
```
/lustre/projects/staton/software/plink_1.9/plink \
--bfile ver1 --read-genome plink.genome --mds-plot 4 --cluster
```
---
