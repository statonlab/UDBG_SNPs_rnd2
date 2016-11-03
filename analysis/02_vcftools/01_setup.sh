#!/bin/bash
# unzip important files needed for processing
gunzip -c ../../raw_data/distribute/all.vcf.gz > all.vcf
gunzip -c ../../raw_data/distribute/all.taxamerged.vcf.gz > all.taxamerged.vcf
gunzip -c ../../raw_data/distribute/all.taxamerged.filtered.recode.vcf.gz > all.taxamerged.filtered.recode.vcf
