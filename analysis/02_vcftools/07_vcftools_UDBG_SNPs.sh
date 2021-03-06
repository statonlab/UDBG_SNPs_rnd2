#!/bin/bash
# drop minDP to 10 from 20
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
