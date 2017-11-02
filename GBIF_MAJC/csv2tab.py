#!/usr/bin/python3

#call script as "python3 csv2tab.py [inputFileName] [outputFileName]
import csv, sys
infile=sys.argv[1]
outfile=sys.argv[2]
with open(infile, 'r') as inf:
    reader = csv.reader(inf)
    with open(outfile, 'w', encoding="utf-8") as out:
        writer = csv.writer(out, delimiter='\t')
        writer.writerows(reader)
