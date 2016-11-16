#!/bin/bash
if [ "foo" = "foo" ]; then
	grep "^#CHROM" 15_CH_TE_MV_3n.vcf | cut -f 10- | sed 's/\t/,DP,/g' | sed 's/^/Location,/g' | sed 's/$/,DP/g'
	cat out.*.tsv
fi > 15_CH_TE_MV_3n.tsv
