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

# module:      filterVCF
# input:       filename
# return:      .
# description: This module is used to read and parse a vcf file into a stream
# to do:       Change to stream
def filterVCF(i_file, depth, o_file=None):
    import re
    import collections
    f = open(i_file, 'r')
    with smartOpen(o_file) as fh:
        # intalize header info
        loc = []
        # process lines in file
        for line in f:
            if line.startswith("##"):
                x = None
            elif line.startswith("#"):
                header = line.split()
                # get set
                for i in header[9:]:
                    loc.append(i)
            else:
                data = line.split()
                # we will use this list to check whether the line contains unique entries
                # the dictionary will store other information for printing
                check = []
                dict  = {}
                for i,l in zip(header[9:],data[9:]):
                    GTDP = "."
                    try:
                        GTDP = l.split(':')
                    except:
                        GTDP = "."
                    # full depth requirement
                    if (not l == ".") and int(GTDP[1]) > depth:
                        store = collections.namedtuple('GT','DP sig')
                        store.sig = "*"
                        store.GT = GTDP[0]
                        store.DP = GTDP[1]
                        dict[(data[1]),i] = store
                        check.append(store.GT)
                    # half of depth requirement
                    elif (not l == ".") and int(GTDP[1]) > depth/2:
                        store = collections.namedtuple('GT','DP sig')
                        store.sig = "**"
                        store.GT = GTDP[0]
                        store.DP = GTDP[1]
                        dict[(data[1]),i] = store
                    elif (not l == ".") and int(GTDP[1]) > depth/3:
                        store = collections.namedtuple('GT','DP sig')
                        store.sig = "***"
                        store.GT = GTDP[0]
                        store.DP = GTDP[1]
                        dict[(data[1]),i] = store
                    else:
                        # if our sample entry doesn't have a genotype call AND does not meet depth requirements set DP and GT to '.'
                        store = collections.namedtuple('GT','DP sig')
                        store.sig = ""
                        store.GT = "."
                        store.DP = "."
                        dict[(data[1]),i] = store
                # now lets check to see if there are any unique entries
                if len(list(set(check))) > 1:
                    out = data[1]
                    for i in dict:
                        if dict[i].GT == ".":
                            out += ",.,."
                        else:
                            #out +=","+dict[i].GT+"("+dict[i].DP+dict[i].sig+")"
                            out +=","+dict[i].GT+dict[i].sig+","+dict[i].DP
                    print >>fh, out
        f.close()

# module:      splitVCF
# input:       filename
# return:      .
# description: This module is used to read and parse a vcf file into a variable amount of vcf files
# to do:       Change to stream
def splitVCF(i_file, numEntry):
    import re
    import collections
    numEntry -= 1
    f = open(i_file, 'r')
    fileNum = 0
    count = numEntry
    header = []
    # process lines in file
    for line in f:
        if line.startswith("##"):
            header.append(line)
        elif line.startswith("#"):
            header.append(line)
        else:
            if count == numEntry:
                count = 0
                fileNum += 1
                fname = "splits."+str(fileNum)
                try:
                    o.close()
                except:
                    x = 0
                o = open(fname, 'w')
                for i in header:
                    print >> o, i.rstrip()
                print >> o, line.rstrip()
                print fname
            else:
                print >> o, line.rstrip()
                count += 1
