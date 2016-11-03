#!/bin/bash
# script counts # of SNVs for each cultivar
i=10
for f in `head -n70 $1 | grep "^#CHROM" | cut -f 10-`; do 
        if [ "foo" = "foo" ]; then
        echo $f
        grep -v "^#" $1 | cut -f $i | grep -v "\." | wc -l
        fi | paste - - 
	let i++
done
