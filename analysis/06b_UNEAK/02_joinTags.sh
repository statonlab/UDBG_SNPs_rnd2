#!/bin/bash
# create a pseudo genome by joining all tags by poly-A strings of 10 ntds. This is necessary to prevent a segfault in freebayes
if [ "0"=="0" ]
then
	echo ">UNEAK_tag_genome"
	sed '1d' 01_UNEAK.topm.tagpairs.txt |\
        sed '2~2d' |\
	cut -f 1 |\
	awk '/^..*$/{ print $0 "AAAAAAAAAAAAAAAAAAAA" ;next}{print}'
fi > 02_UNEAK_genome.fasta
module load java/jdk8u5
java -jar /lustre/projects/staton/software/picard-tools-2.1.0/picard.jar \
CreateSequenceDictionary \
R=02_UNEAK_genome.fasta \
O=02_UNEAK_genome.dict
