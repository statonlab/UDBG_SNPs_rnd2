#!/bin/bash
cut -f 3,4 HWTWGBGXX_1_fastq.gz.keys.txt | sed 's/ \+/\t/g' | awk -F'\t' '{print$2,$1}' OFS='\t' | while read -r line || [[ -n "$line" ]]; do
echo "$line	s	HWTWGBGXX_1.fastq"
done > barcode_HWTWGBGXX_1.txt
