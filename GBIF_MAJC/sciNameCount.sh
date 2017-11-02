#!/bin/bash

#process tab delimited occurrence data for scientific names
#call as extractSciName.sh [occurence tsv file] [optional: output filename for results]
#assumes read_headers.py is in the same directory
#assumes csv2tab.py is in the same directory (only required if input file is in csv format)

#set input and output file names
infile=$1
outfile=sciNames.txt
if [ $# -eq 2 ]; then
	outfile=$2
fi

echo -----------------
echo Finding the scientificNames from $infile and writing list to $outfile ...
echo -----------------
echo

#check for and convert .csv files
if [[ $1 == *".csv" ]]; then
	in2=${infile%.csv}_tabDelim.txt
	echo Converting $infile to tab delimted file $in2 ...
	python3 csv2tab.py $infile $in2
	infile=$in2
	#echo $infile
fi


echo Parsing headers in $infile ...

#Read header line into fields.txt
python3 read_headers.py $infile fields.txt

#Convert python 'scientificName' index (starting with 0) to bash number (starting with 1) as variable SNIF
SNIF=$(($(cat fields.txt | grep -i "scientificName$(printf '\t')" | cut -f2)+1))
#echo $SNIF


echo Parsing $infile scientific names ...
#Sort and count scientific names
tail -n +2 $infile | cut -f${SNIF} | sort | uniq -c | sort -nr > $outfile

echo
echo -----------------
echo Finished processing $infile  and saved names to $outfile !
echo -----------------