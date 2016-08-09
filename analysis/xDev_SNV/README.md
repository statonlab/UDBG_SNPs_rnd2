Dev directory for informative SNPs software.
####locations with a call
```
grep -v "^#" $1 |\
cut -f 10- |\
head
```
---
####check for presence in vcf file of a snp
```
grep -v "^#" $1 |\
cut -f 6 |\
sort |\
uniq -c |\
sed 's/^ *//g' |\
awk '{ t = $1; $1 = $2; $2 = t; print; }' |\
sort
```
---
