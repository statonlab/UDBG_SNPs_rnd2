####create links to important files
```
ln -s ../../raw_data/HWTWGBGXX_1.fastq ./
ln -s ../../../UDBG_SNPs_rnd1/raw_data/C7PDKANXX_7_fastq  ./
ln -s ../../raw_data/distribute/keyfile.txt ./
```
---
####convert fastq to tag counts
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx12G -fork1 -FastqToTagCountPlugin \
-i Illumina \
-k key/keyfile.txt \
-e ApeKI \
-s 300000000 \
-c 1 \
-o ./tagCounts \
-endPlugin -runfork1
```
---
####run merge tag count plugin
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -MergeMultipleTagCountPlugin \
-i ./tagCounts \
-o ./tagCounts/merged.cnt \
-c 3 \
-endPlugin -runfork1
```
---
####convert tag count to fastq
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -TagCountToFastqPlugin –c 3 \
-o ./tagCounts/merged.fastq \
-i ./tagCounts/merged.cnt \
-endPlugin -runfork1
```
---
####create tag count paired output
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -UTagCountToTagPairPlugin \
–e 0.03 \
-o ./tagPair/UNEAK.tp \
-i ./tagCounts/merged.cnt \
-endPlugin -runfork1
```
---
####export tagpairs to UNEAK.topm format
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -UExportTagPairPlugin \
-d 100 \
-t ./topm/UNEAK.topm.txt \
-i ./tagPair/UNEAK.tp \
-endPlugin -runfork1
```
---
####convert tag count to topm.bin format
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -UExportTagPairPlugin \
-d 100 \
-m ./topm/UNEAK.topm.bin \
-i ./tagPair/UNEAK.tp \
-endPlugin -runfork1
#-t ./topm/UNEAK.topm.txt \
```
---
####convert fastq data to TBT format
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -fork1 -FastqToTBTPlugin \
-e ApeKI \
-y -t ./tagCounts/merged.cnt \
-c 1 \
-k ./key/keyfile.txt \
–m ./topm/UNEAK.topm.bin \
-o ./TBT \
-i ./Illumina \
-endPlugin -runfork1
```
---
####merge the taxa files 
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx12G -fork1 -MergeTagsByTaxaFilesPlugin \
-s 300000000 \
-o ./MergeTBT/UNEAK.tbt.byte \
-i ./TBT \
-endPlugin -runfork1
```
---
####convert tbt to vcf fomrat
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx12G -fork1 -tbt2vcfPlugin \
-i ./MergeTBT/UNEAK.tbt.byte \
-ak 3 \
-mnLCov 0 \
-m ./topm/UNEAK.topm.bin \
-mnMAF 0.01 \
-o ./vcf/ \
-s 1 \
-e 1 \
-endPlugin -runfork1
```
---
####merge duplicate snps in the vcf file
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx50G -fork1 -MergeDuplicateSNP_vcf_Plugin \
-i ./vcf/MergeTBT.c1 \
-o ./vcf/1.vcf \
-ak 3 \
-endPlugin -runfork1
```
---
####convert back to vcf again
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx50G -fork1 -tbt2vcfPlugin \
-i ./MergeTBT/UNEAK.tbt.byte \
-ak 3 \
-mnLCov 0 \
-m ./topm/UNEAK.topm.bin \
-mnMAF 0.01 \
-o ./vcfMerge/ \
-s 1 \
-e 1 \
-endPlugin -runfork1
```
---
####merge duplicate snps in the vcf file again
```
/lustre/projects/staton/software/TASSEL3/run_pipeline.pl -Xms512m -Xmx50G -fork1 -MergeDuplicateSNP_vcf_Plugin \
-i ./vcfMerge/MergeTBT.c1 \
-o ./vcf/1.taxamerged.vcf \
-ak 3 \
-endPlugin -runfork1
```
---
