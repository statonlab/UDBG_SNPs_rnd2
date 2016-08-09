####create a link for our vcf results from 06b_UNEAK
```
ln -s ../06b_UNEAK/12_all.vcf ./
```
####we need to fix some of the weird naming artifacts from combining in GATK and also change the UNEAK_tag_genome to 1 so it can be processed by plink
```
sed 's/\.variant2//g' 12_all.vcf | sed 's/\.variant3//g' | sed 's/\.variant//g' | sed 's/UNEAK_tag_genome/1/g' > 12_all_fix.vcf
```
---
####have plink load the vcf file into a plink-useable format
```
/lustre/projects/staton/software/plink_1.9/plink \
--vcf 12_all_fix.vcf --make-bed --out ver1
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
