#!/bin/bash
# xDev_convert2n.py converts the 3n and 4n into a 2n-like format so it can be processed by plink
module load python/2.7.11
../xDev_SNV/xDev_convert2n.py --i 07_3n_freebayes.vcf > 07_3n_2n_freebayes.vcf &
../xDev_SNV/xDev_convert2n.py --i 07_4n_freebayes.vcf > 07_4n_2n_freebayes.vcf &
