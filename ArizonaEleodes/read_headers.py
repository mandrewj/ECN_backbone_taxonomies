#!/usr/bin/python3

#call script as "python3 read_headers.y [inputFileName]
#For specified tab-delimited infile
#print (to standard output) the python index for each column
import sys
fileout=False
if len(sys.argv)> 1:
    if len(sys.argv) > 2:
            outfile=sys.argv[2]
            fileout=True

    infile=sys.argv[1]

    with open(infile, "r", encoding="utf-8") as infile:
        line1=infile.readline()
        elem=line1.split("\t")
        if fileout:
            with open(outfile, "w", encoding="utf-8") as outfile:
                for item in elem:
                    outfile.write(str(item)+"\t"+str(elem.index(item))+"\n")
        else:
            for item in elem:
                print(str(elem.index(item))+"\t"+str(item))
else:
    print("Call script with name of input file.")
