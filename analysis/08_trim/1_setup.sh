#!/bin/bash
# create links to important fastq data and remove the blank
ln -s ../../raw_data/*.fastq ./
rm -f HWTWGBGXX_1.fastq BLANK.fastq
