#!/bin/bash
# use samtools to merge 2n's into one file
module load samtools
samtools merge 06_2n.bam 05_DA1.head.bam 05_DA2.head.bam 05_DA3.head.bam 05_DB1.head.bam 05_DB2.head.bam 05_DB3.head.bam
samtools index 06_2n.bam
