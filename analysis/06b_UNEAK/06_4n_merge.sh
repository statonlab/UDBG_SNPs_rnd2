#!/bin/bash
# use samtools to merge 4n's into one file
module load samtools
samtools merge 06_4n.bam 05_TA1.head.bam 05_TA2.head.bam 05_TA3.head.bam 05_TB1.head.bam 05_TB2.head.bam 05_TB3.head.bam
samtools index 06_4n.bam
