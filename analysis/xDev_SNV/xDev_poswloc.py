#!/usr/bin/env python
# tested on python 2.7.3

import getopt, sys
import xDev_SNV_modules

def main():
    # command line parsing
    try:
        options, args = getopt.getopt(sys.argv[1:], "hoi.v", ["help", "output=","input="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print str(err)
        xDev_SNV_modules.usage()
        sys.exit(2)
    output = None
    verbose = False
    for opt, arg in options:
        if opt == "-v":
            verbose = True
        elif opt in ("-h", "--help"):
            xDev_SNV_modules.usage()
            sys.exit()
        elif opt in ("-o", "--output"):
            output = arg
        elif opt in ("-i", "--input"):
            file = arg
        else:
            assert False, "unhandled option"

    # read input vcf file into dictionary
    # example: dict['699667','DA','1'] = ('0/0','8')
    # dict is broken up into pos, loc, od... 
    # pos : list of unique reference positions
    # loc : dict of key/value pairs for species and # of ids
    # od  : ordered dictionary of all results using tuple of pos, species, id# as key
    print "Reading VCF file..."
    dict = xDev_SNV_modules.readVCF(file)
    results = xDev_SNV_modules.locWithCall(dict,output)
    

if __name__ == "__main__":
    main()
