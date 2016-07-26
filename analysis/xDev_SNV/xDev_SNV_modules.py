#!/usr/bin/env python
# tested on python 2.7.3

# module:      .
# input:       .
# return:      .
# description: .
# to do:       .
def PT():
    print "Just a prototype module."


# module:      usage
# input:       none
# return:      none
# description: Prints help menu for user.
# to do:       Write expanded help menu.
def usage():
    print ""
    print "Run as xDev_SNV.py --i [file.vcf] --o [base]"
    print ""
    print "If no output file is specified the output will print to stdout"

# module:      smartOpen
# input:       filename
# return:      filehandle
# description: opens a filename if specified or stdout
# to do:       none
# credit:      Wolph @ http://stackoverflow.com/questions/17602878/how-to-handle-both-with-open-and-sys-stdout-nicely
import sys
import contextlib
@contextlib.contextmanager
def smartOpen(filename=None):
    if filename and filename != '-':
        fh = open(filename, 'w')
    else:
        fh = sys.stdout
    try:
        yield fh
    finally:
        if fh is not sys.stdout:
            fh.close()

# module:      readVCF
# input:       filename
# return:      dictionary of dictionary, list, dictionary
# description: This module is used to read and parse a vcf file into
# a total of three objects: an ordered dictionary of positions, cultivars,
# individuals, genotypes, and read depths, a list of genomic positions, and 
# a dictionary containing the header info the vcf file
# to do:       Add extra support for parsing cultivar / species names. Currently
# only supports names of Letter# format. Eg. DA1, DA2, DA3 belong to DA and DB1,
# DB2, DB3 belong to DB. 
def readVCF(file):
    import re
    import collections
    # initialize dictionary for storing file
    # dictionary will have two be able to reference position
    # as well as individual (which has to components species / id#)
    dict = {}
    # initialize array to store possible reference position
    pos = []
    # initialize dictionary to store header info
    loc = {}
    f = open(file, 'r')
    # process lines in file
    for line in f:
        if line.startswith("##"):
            x = None
        elif line.startswith("#"):
            header = line.split()
            # get set
            tmp = []
            for i in header[9:]:
                m = re.search('(\D+)(\d+)', i)
                tmp.append(m.group(1))
            for x in list(set(tmp)):
                loc[x] = tmp.count(x)
        else:
            #print len(header[9:])
            data = line.split()
            for i,l in zip(header[9:],data[9:]):
                m = re.search('(\D+)(\d+)', i)
                try:
                    GTDP = l.split(':')
                    # dictionary structure example: dict['699667','DA','1'] = ('0/0','8')
                    dict[(data[1],m.group(1),m.group(2))] = (GTDP[0],GTDP[1])
                    #print data[1],m.group(1),m.group(2)
                    pos.append(data[1])
                except:
                    # if our sample entry doesn't have a genotype call set DP and GT to '.'
                    dict[(data[1],m.group(1),m.group(2))] = ('.','.')
                    # we'll just ignore empty pos for now...
    f.close()
    # we want an ordered dictionary
    #od = collections.OrderedDict(sorted(dict.items())) # don't need an ordered dictionary since we have an index
    # let's keep only unique values from pos by using set
    pos = list(set(pos))
    # return as a dictionary inlucding... a dictionary, a list, and a location dictionary
    return {'dict':dict, 'pos':pos, 'loc':loc}

# module:      collapseCultivars
# input:       dictionary and depth cutoff for acceptable call
# return:      dictionary
# description: this module takes a dictionary of a vcf file and attempts to collapse multiple cultivar
# SNV calls into a single call. 
# to do:       make significance level more variable
def collapseCultivars(i_dict, depth, allow60 = "no"):
    import re
    import collections
    # intialize our return dictionary
    n_dict = {}
    # intialize our return lists
    positions = []
    cultivars = []
    # cycle through all positions containing a SNP
    for i in i_dict['pos']:
        #print "#", i
        # for each position containing a SNP obtain a genotype and count (for genotype) at that position
        for key, value in i_dict['loc'].iteritems():
            #print key,value
            # lists for calculating values
            geno = []
            full = []
            avgD = []
            # we need to inailize a counter variable for later
            counter = collections.Counter()
            # each species will have a variable number of samples... go through each of the samples per species
            for l in range(1, value+1):
                #print i,key,l,i_dict['dict'][(i,key,str(l))]
                # grab genotype and depth for each sample
                GT, DP = i_dict['dict'][(i,key,str(l))]
                # does this sample have a genotype call? is the depth 10 or higher? if yes add to list
                if GT != '.' and int(DP) >= depth:
                    geno.append(GT)
                    avgD.append(int(DP))
                full.append(GT)
            # now to inspect the frequencies of each of the samples
            if geno:
                counter = collections.Counter(geno)
                store = collections.namedtuple('GT','DP pct sig avgD')
                #store.GT = counter.most_common(1)[0][0]
                #store.DP = counter.most_common(1)[0][1]
                #store.pct = float(counter.most_common(1)[0][1])/float(len(full))
                # if all individuals meet quality checks... we use *
                if float(counter.most_common(1)[0][1])/float(len(full)) == 1:
                    store.sig = "*"
                    store.GT = counter.most_common(1)[0][0]
                    store.DP = format(counter.most_common(1)[0][1], '.2f')
                    store.pct = format(float(counter.most_common(1)[0][1])/float(len(full)), '.2f')
                    store.avgD = format(float(sum(avgD))/float(len(avgD)), '.2f')
                # if 80% of individuals of this cultivar have the same genotype... we use **
                elif float(counter.most_common(1)[0][1])/float(len(full)) >= 0.80:
                    store.sig = "**"
                    store.GT = counter.most_common(1)[0][0]
                    store.DP = format(counter.most_common(1)[0][1], '.2f')
                    store.pct = format(float(counter.most_common(1)[0][1])/float(len(full)), '.2f')
                    store.avgD = format(float(sum(avgD))/float(len(avgD)), '.2f')
                # if 60% of individuals of this cultivar have the same genotype... we use *** (requires flag allow60 be set to "yes")
                elif float(counter.most_common(1)[0][1])/float(len(full)) >= 0.60 and allow60 == "yes":
                    store.sig = "***"
                    store.GT = counter.most_common(1)[0][0]
                    store.DP = format(counter.most_common(1)[0][1], '.2f')
                    store.pct = format(float(counter.most_common(1)[0][1])/float(len(full)), '.2f')
                    store.avgD = format(float(sum(avgD))/float(len(avgD)), '.2f')
                # not significant
                else:
                    store.sig = ""
                    store.GT = "."
                    store.DP = "0"
                    store.pct = "0"
                    store.avgD = "0"
#                print store.avgD
                # store these so we can cycle through the dictionary in an indexed fashion
                n_dict[(i,key)] = store
            else:
                store = collections.namedtuple('GT','DP pct sig')
                store.GT = "."
                store.DP = "0"
                store.pct = "0"
                store.sig = ""
                store.avgD = "0"
                n_dict[(i,key)] = store
            positions.append(i)
            cultivars.append(key)
    return {'n_dict':n_dict, 'positions': list(set(positions)), 'cultivars': list(set(cultivars))}

# module:      findInformativePositions
# input:       collapseCultivars dictionary
# return:      dictionary
# description: determines informative positions in a collapseCultivar dictionary
# to do:       .
def findInformativePositions(i_dict):
    # return variables
    n_dict = {}
    cultivars = []
    positions = []
    # process position by position
    for i in i_dict['positions']:
        check = []
        for key in i_dict['cultivars']:
            if not i_dict['n_dict'][(i,key)].GT == "." :
                check.append(i_dict['n_dict'][(i,key)].GT)
        if len(list(set(check))) > 1:
            for key in i_dict['cultivars']:
                n_dict[(i,key)] = i_dict['n_dict'][(i,key)]
                positions.append(i)
                cultivars.append(key)
    return {'n_dict':n_dict, 'positions': list(set(positions)), 'cultivars': list(set(cultivars))}

# module:      printMatrix
# input:       findInformativePositions dictionary or collapseCultivars dictionary
# return:      none
# description: module for printing out vcf dictionary
# to do:       none
def printMatrix(i_dict,option,file=None):
    out = "position"
    # open file handle with smart open, if no file open will go to stdout
    with smartOpen(file) as fh:
        # header
        if not option == "full":
            for i in i_dict['cultivars']:
                out+=","+i
            print >>fh, out
        else:
            for i in i_dict['cultivars']:
                out+=","+i+" Genotype"+","+i+" Average Depth"+","+i+" Represented"+","+i+" Proportion Represented"
            print >>fh, out
        # body
        # clean option prints wihtout sig or avgD
        if option == "clean":
            for i in i_dict['positions']:
                out = i
                check = []
                for key in i_dict['cultivars']:
                    out+=","+i_dict['n_dict'][(i,key)].GT
                    check.append(i_dict['n_dict'][(i,key)].GT)
                if not list(set(check))[0] == "." and not len(list(set(check))) == 1:
                    print >>fh, out
        elif option == "full":
            for i in i_dict['positions']:
                out = i
                check = []
                for key in i_dict['cultivars']:
                    out+=","+i_dict['n_dict'][(i,key)].GT+i_dict['n_dict'][(i,key)].sig+","+str(i_dict['n_dict'][(i,key)].avgD)+","+str(i_dict['n_dict'][(i,key)].DP)+","+str(i_dict['n_dict'][(i,key)].pct)
                    check.append(i_dict['n_dict'][(i,key)].GT)
                if not list(set(check))[0] == "." and not len(list(set(check))) == 1:
                    print >>fh, out
        # sig is deafult prints like clean but with *'s to the right to indicate significance of entries and (#)'s to the left to
        # indicate depth
        else:
            for i in i_dict['positions']:
                out = i
                check = []
                for key in i_dict['cultivars']:
                    out+=","+"("+i_dict['n_dict'][(i,key)].avgD+")"+i_dict['n_dict'][(i,key)].GT+i_dict['n_dict'][(i,key)].sig
                    check.append(i_dict['n_dict'][(i,key)].GT)
                # don't print anything that only contains .'s
                if not list(set(check))[0] == "." and not len(list(set(check))) == 1:
                    print >>fh, out
