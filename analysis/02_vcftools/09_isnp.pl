#!/usr/bin/perl

# script takes .vcf file containing CH, MV, TD, TE, and/or TG as input and outputs potentially informative loci in column 1 and which subspecies they are informative for in column 2
# eg.
# 29566539	TG Informative
# 2437827	TG Informative
# 47673935	TG Informative
# 43385737	TG Informative
# 15725224	TG Informative
# 30820618	TG Informative
# 11261835	TG Informative
# 39550315	TG Informative
# 16984634	TG Informative
# 48124634	TG Informative
# 17335340	CH Informative
# 18396328	CH Informative
# 44651644	CH Informative
# 8827727	CH Informative
# 14538339	CH Informative
# 31238052	CH Informative
# 38789142	CH Informative

# input vcf file
my $file = shift;
open IN, $file or die;

# global variables
my %CH;
my %MV;
my %TD;
my %TE;
my %TG;

while(<IN>) {
	chomp;
	unless($_ =~ m/^##/g) {
		if ($_ =~ m/^#/g) {
			my @fields = split(/\t/);
# fields from vcf file debugging lines
#			print $fields[1] . "\t" . $fields[9] . "\t" . $fields[10] . "\t" . $fields[11] . "\t" . $fields[12] . "\t" . $fields[13] . "\t" . $fields[14] . "\n";
#			print $fields[1] . "\t" . $fields[15] . "\t" . $fields[16] . "\t" . $fields[17] . "\t" . $fields[18] . "\t" . $fields[19] . "\n";
#			print $fields[1] . "\t" . $fields[20] . "\t" . $fields[21] . "\t" . $fields[22] . "\t" . $fields[23] . "\t" . $fields[24] . "\t" . $fields[25] . "\n";
#			print $fields[1] . "\t" . $fields[26] . "\t" . $fields[27] . "\t" . $fields[28] . "\t" . $fields[29] . "\t" . $fields[30] . "\t" . $fields[31] . "\n";
#			print $fields[1] . "\t" . $fields[32] . "\t" . $fields[33] . "\t" . $fields[34] . "\t" . $fields[35] . "\t" . $fields[36] . "\t" . $fields[37] . "\n";
		} else {
			my @fields = split(/\t/);
			my $count = 0;
			for my $fieldTest (@fields) {
				if ($fieldTest eq "\.\/\.") {
					$count++;
				}
			}
			unless ($count > 1) {
			#-----------------------#
			# handle CH - Champions #
			#-----------------------#
			my @list = (pg($fields[9]),pg($fields[10]),pg($fields[11]),pg($fields[12]),pg($fields[13]),pg($fields[14]));
			@list = grep { !/\.\/\./ } @list;
			@list = grep { $_ != -1 } @list;
                        #print $fields[2] . "\t" . $fields[9] . "\t" . $fields[10] . "\t" . $fields[11] . "\t" . $fields[12] . "\t" . $fields[13] . "\t" . $fields[14] . "\n";
			#print "$list[0]\t$list[1]\t$list[2]\t$list[3]\t$list[4]\t$list[5]\n";
			# if they are all equal save in hash as informative - 1
			if ( !grep $_ != $list[0], @list ) {
				$CH{$fields[1]} = $list[0];
				#print $list[0] . "\n";
				#print $CH{$fields[1]} . "\n";
				#print $fields[1] . "\n";
			# if they are not all equal save in has as uninformative - -1
			} else {
				$CH{$fields[1]} = -1;
				#print "-1\n";
			}
			#-----------------------#
			# handle MV - MiniVerde #
			#-----------------------#
			@list = (pg($fields[15]),pg($fields[16]),pg($fields[17]),pg($fields[18]),pg($fields[19]));
                        @list = grep { !/\.\/\./ } @list;
                        @list = grep { $_ != -1 } @list;
			# if they are all equal save in has as informative - 1
			#print $fields[1] . "\t" . $fields[15] . "\t" . $fields[16] . "\t" . $fields[17] . "\t" . $fields[18] . "\t" . $fields[19] . "\n";
			if ( !grep $_ != $list[0], @list ) {
                                $MV{$fields[1]} = $list[0];
				#print $list[0] . "\n";
			# if they are not all equal save in has as uninformative - -1
			} else {
                                $MV{$fields[1]} = -1;
				#print "-1\n";
                        }
			#-----------------------#
			# handle TD - Tiffdwarf #
			#-----------------------#
			@list = (pg($fields[20]),pg($fields[21]),pg($fields[22]),pg($fields[23]),pg($fields[24]),pg($fields[25]));
                        @list = grep { !/\.\/\./ } @list;
                        @list = grep { $_ != -1 } @list;
			# if they are all equal save in has as informative - 1
			#print $fields[1] . "\t" . $fields[20] . "\t" . $fields[21]  . "\t" . $fields[22] . "\t" .$fields[23] . "\t" . $fields[24] . "\t" . $fields[25] . "\n";
			if ( !grep $_ != $list[0], @list ) {
                                $TD{$fields[1]} = $list[0];
                                #print $list[0] . "\n";
			# if they are not all equal save in has as uninformative - -1
			} else {
                                $TD{$fields[1]} = -1;
                                #print "-1\n";
                        }
			#-----------------------#
			# handle TE - TiffEagle #
			#-----------------------#
			@list = (pg($fields[26]),pg($fields[27]),pg($fields[28]),pg($fields[29]),pg($fields[30]),pg($fields[31]));
                        @list = grep { !/test/ } @list;
                        @list = grep { $_ != -1 } @list;
			# if they are all equal save in has as informative - 1
			#print $fields[1] . "\t" . $fields[26] . "\t" . $fields[27] . "\t" . $fields[28] . "\t" . $fields[29] . "\t" .$fields[30] . "\t" . $fields[31] . "\n";
			if ( !grep $_ != $list[0], @list ) {
                                $TE{$fields[1]} = $list[0];
                                #print $list[0] . "\n";
			# if they are not all equal save in has as uninformative - -1
			} else {
                                $TE{$fields[1]} = -1;
                                #print "-1\n";
                        }
			#-----------------------#
			# handle TG - Tiffgreen #
			# ----------------------#
			@list = (pg($fields[32]),pg($fields[33]),pg($fields[34]),pg($fields[35]),pg($fields[36]),pg($fields[37]));
                        @list = grep { !/\.\/\./ } @list;
                        @list = grep { $_ != -1 } @list;
			# if they are all equal save in has as informative
			#print $fields[1] . "\t" . $fields[32] . "\t" . $fields[33] . "\t" . $fields[34] . "\t" . $fields[35] . "\t" . $fields[36] . "\t" . $fields[37] . "\n";
			if ( !grep $_ != $list[0], @list ) {
                                $TG{$fields[1]} = $list[0];
                                #print $list[0] . "\n";
			# if they are not all equal save in has as uninformative
			} else {
                                $TG{$fields[1]} = -1;
                                #print "-1\n";
                        }
                        }
		}
	}
}


# TG, TE, TD, MV, CH
#foreach my $key (keys %TG) {
#                my @list = ($TG{$key},$TE{$key},$TD{$key},$MV{$key},$CH{$key});
#                my @sublist = ($TE{$key}, $TD{$key}, $MV{$key}, $CH{$key});
#                if ( !grep $_ != $list[0], @list ) {
#                        print $key . "\tUninformative\n";
#                } elsif ( !grep $_ == $TG{$key}, @sublist) {
#                        print $key . "\tTG Informative\n"
#                } else {
#                        print $key . "\tPartially informative\n";
#                }
#}

#----------------------------------------#
# print structures for informative sites #
#----------------------------------------#
foreach my $key (keys %TG) {
                                if ($TE{$key} != -1 && $TE{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "TG -> TE Informative\t" . $key . "\n";
                                }
                                if ($TD{$key} != -1 && $TD{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "TG -> TD Informative\t" . $key . "\n";
                                }
                                if ($MV{$key} != -1 && $MV{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "TG -> MV Informative\t" . $key . "\n";
                                }
                                if ($CH{$key} != -1 && $CH{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "TG -> CH Informative\t" . $key . "\n";
                                }
}

foreach my $key (keys %TE) {
                                if ($TE{$key} != -1 && $TE{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "TE -> TG Informative\t" . $key . "\n";
                                }
                                if ($TD{$key} != -1 && $TD{$key} != $TE{$key} && $TE{$key} != -1)
                                {
                                        print "TE -> TD Informative\t" . $key . "\n";
                                }
                                if ($MV{$key} != -1 && $MV{$key} != $TE{$key} && $TE{$key} != -1)
                                {
                                        print "TE -> MV Informative\t" . $key . "\n";
                                }
                                if ($CH{$key} != -1 && $CH{$key} != $TE{$key} && $TE{$key} != -1)
                                {
                                        print "TE -> CH Informative\t" . $key . "\n";
                                }
}

foreach my $key (keys %TD) {
                                if ($TE{$key} != -1 && $TE{$key} != $TD{$key} && $TD{$key} != -1)
                                {
                                        print "TD -> TE Informative\t" . $key . "\n";
                                }
                                if ($TD{$key} != -1 && $TD{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "TD -> TG Informative\t" . $key . "\n";
                                }
                                if ($MV{$key} != -1 && $MV{$key} != $TD{$key} && $TD{$key} != -1)
                                {
                                        print "TD -> MV Informative\t" . $key . "\n";
                                }
                                if ($CH{$key} != -1 && $CH{$key} != $TD{$key} && $TD{$key} != -1)
                                {
                                        print "TD -> CH Informative\t" . $key . "\n";
                                }
}

foreach my $key (keys %MV) {
                                if ($TE{$key} != -1 && $TE{$key} != $MV{$key} && $MV{$key} != -1)
                                {
                                        print "MV -> TE Informative\t" . $key . "\n";
                                }
                                if ($TD{$key} != -1 && $TD{$key} != $MV{$key} && $MV{$key} != -1)
                                {
                                        print "MV -> TD Informative\t" . $key . "\n";
                                }
                                if ($MV{$key} != -1 && $MV{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "MV -> TG Informative\t" . $key . "\n";
                                }
                                if ($CH{$key} != -1 && $CH{$key} != $MV{$key} && $MV{$key} != -1)
                                {
                                        print "MV -> CH Informative\t" . $key . "\n";
                                }
}

foreach my $key (keys %CH) {
                                if ($TE{$key} != -1 && $TE{$key} != $CH{$key} && $CH{$key} != -1)
                                {
                                        print "CH -> TE Informative\t" . $key . "\n";
                                }
                                if ($TD{$key} != -1 && $TD{$key} != $CH{$key} && $CH{$key} != -1)
                                {
                                        print "CH -> TD Informative\t" . $key . "\n";
                                }
                                if ($MV{$key} != -1 && $MV{$key} != $CH{$key} && $CH{$key} != -1)
                                {
                                        print "CH -> MV Informative\t" . $key . "\n";
                                }
                                if ($CH{$key} != -1 && $CH{$key} != $TG{$key} && $TG{$key} != -1)
                                {
                                        print "CH -> TG Informative\t" . $key . "\n";
                                }
}

# pg eq process genotype
sub pg {
	my @geno = split(/:/,shift);
	if ($geno[0] eq "0/0") {
		return "0";
	} elsif ($geno[0] eq "0/1") {
		return "1";
	} elsif ($geno[0] eq "1/1") {
		return "2";
	} elsif ($geno[0] eq "./.") {
		return "-1";
	} else {
		print "ERROR\nsub process_genotype\n";
	}
}
