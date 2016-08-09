#!/bin/bash
# setupt directory
ln -s ../07b_PLINK/plink.mds ./
sed '1d' plink.mds > plink_alter.mds
