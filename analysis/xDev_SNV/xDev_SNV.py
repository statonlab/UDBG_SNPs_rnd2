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
    print "Collapsing cultivars..."
    results = xDev_SNV_modules.collapseCultivars(dict, 5, "yes")
    print "Determining informative sites..."
    informative = xDev_SNV_modules.findInformativePositions(results)
    
    # print results
    print "Saving results to: "+output
    if output:
        xDev_SNV_modules.printMatrix(informative,"clean",output+"_informative.clean.tsv")
        xDev_SNV_modules.printMatrix(informative,"sig",output+"_informative.sig.tsv")
        xDev_SNV_modules.printMatrix(informative,"full",output+"_informative.full.tsv")
        xDev_SNV_modules.printMatrix(results,"clean",output+"_full.clean.tsv")
        xDev_SNV_modules.printMatrix(results,"sig",output+"_full.sig.tsv")
        xDev_SNV_modules.printMatrix(results,"full",output+"_full.full.tsv")

    #xDev_SNV_modules.printMatrix(results,"clean")
    #for i in informative['n_dict'].iteritems():
    #    print i
    #print informative['n_dict'][('22002399', 'DA')].sig
    #print results['n_dict'][('144308688', 'DA')].pct
    #print results['n_dict'][('144308688', 'DA')].GT
    #print results['n_dict'][('144308688', 'DA')].DP

if __name__ == "__main__":
    main()
