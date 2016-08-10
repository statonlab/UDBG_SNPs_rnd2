#!/bin/bash
# setupt directory
ln -s ../06c_PLINK/plink.mds ./
sed '1d' plink.mds |\
grep -v "MV6" |\
grep -v "S28" |\
grep -v "S26" |\
grep -v "S32" |\
grep -v "S19" |\
grep -v "S44" |\
grep -v "S30" > plink_alter.mds
