ln -s ../../07_UNEAK/15_3n_freebayes.vcf ./
#cut -f 1-9,12-14 15_3n_freebayes.vcf > 15_CH_TE_MV_3n.vcf
```
---
./zDev_Split.py --i 15_CH_TE_MV_3n.vcf
./zDev_submit.sh
```
---
if [ "foo" = "foo" ]; then
	grep "^#CHROM" 15_CH_TE_MV_3n.vcf | cut -f 10- | sed 's/\t/,DP,/g' | sed 's/^/Location,/g' | sed 's/$/,DP/g'
	cat out.*.tsv
fi > 15_CH_TE_MV_3n.tsv
```
---
####small script to submit scripts to newton
```
for f in `ls splits.*`
do
echo "#$ -N $f
#$ -q medium*
#$ -cwd
#$ -o ./out.$f.o.txt
#$ -e ./out.$f.e.txt
./zDev_SNV_pooled.py \
--i $f \
--o out.$f.tsv" > job.ogs
qsub job.ogs
rm -f job.ogs
done
```
---
