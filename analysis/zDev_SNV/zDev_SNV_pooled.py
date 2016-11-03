#!/usr/bin/env python
# tested on python 2.7.3

import getopt, sys
import zDev_SNV_modules

def main():
    # let's throw an error and exit if they are using a version of python other than 2.7.3
    #if sys.version_info!=(2.7.3):
    #    raise SystemExit('Sorry, please load python/2.7.3 module')
    # command line parsing
    try:
        options, args = getopt.getopt(sys.argv[1:], "hoi.v", ["help", "output=","input="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print str(err)
        zDev_SNV_modules.usage()
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
    
    # od  : ordered dictionary of all results using tuple of pos, species, id# as key
#    print "Reading VCF file..."
    dict = zDev_SNV_modules.filterVCF(file, 40, output)

if __name__ == "__main__":
    main()
