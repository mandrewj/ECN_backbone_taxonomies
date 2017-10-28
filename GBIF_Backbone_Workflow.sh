#!/bin/bash
#GBIF Backbone Taxonomy Workflow
# Oct 7, 2017 M. Andrew Johnston, data generation for ECN talk
#assumes GBIF Backbone Taxonomy was downloaded from website ('backbone.zip') and in same directory


#--------------
#Prep workspace
#--------------
#unzip DwC archive
unzip backbone.zip -d backbone/
#change directory
cd backbone/


#------------
#Taxon Filter
#------------
#Search for family Tenebrionidae (Note: replace text in quotes with taxon of interest, rename files appropriately)
cat Taxon.tsv | grep "Tenebrionidae" > Tenebrionidae.tsv
#count lines (taxon entries) in Tenebrionidae file
wc -l Tenebrionidae.tsv


#-----------------
#Count taxon ranks/statuses
#-----------------
#counts of names by rank (by taxonRank field, 12th column)
cat Tenebrionidae.tsv | cut -f12 | sort | uniq -c
#counts of names by acceptance (by taxonomicStatus, 15th column)
cat Tenebrionidae.tsv | cut -f15 | sort | uniq -c
#counts 'accepted' names by rank
cat Tenebrionidae.tsv | grep "accepted" | cut -f12 | sort | uniq -c
#counts of species group names (species/subspecies) by acceptance
cat Tenebrionidae.tsv | grep "species" | cut -f15 | sort | uniq -c

#Note: There is some small noise here from taxonRemarks comments that might include these words.
#Note: To save these names instead of counting, replace the '| sort | uniq -c' with '> output.tsv'


#---------------------
#Extract Eleodes names
#---------------------
cat Taxon.tsv | grep "Eleodes" > Eleodes.tsv
#I then analyzed this file by hand against my records of known species.

#Finding all possible names
cat Taxon.tsv | grep "\t4724278\t" > AllEleodes.txt
cat Taxon.tsv | grep "\tEleodes" >> AllEleodes.txt
cat Taxon.tsv | grep "\tCratidus" >> AllEleodes.txt
cat Taxon.tsv | grep "\tAmphidora" >> AllEleodes.txt
cat AllEleodes.txt | sort | uniq >EleodesUniq.txt
cat EleodesUniq.txt | grep "\tspecies" > EleodesSpecies.txt


#Sum up uniq -c counts:
cat NamesEleodesVerb.txt | awk '{s+=$1} END {print s}'


###########################################################################
#Move sciNameCount.sh, read_headers.py, and csv2tab.py to working directory
###########################################################################
./sciNameCount.sh occurrence.txt NamesOccur.txt
./sciNameCount.sh verbatim.txt NamesVerb.txt

#Get Eleodes only from MAJC
head -1 occurrence.txt > EleodesOccur.txt
cat occurrence.txt | grep -i "Eleodes" >> EleodesOccur.txt
./sciNameCount.sh EleodesOccur.txt NamesEleodesOccur.txt

head -1 verbatim.txt > EleodesVerb.txt
cat verbatim.txt | grep -i "Eleodes" >> EleodesVerb.txt
./sciNameCount.sh EleodesVerb.txt NamesEleodesVerb.txt

#iDigBio requires the occurrence.csv file to be converted to utf-8 tab-delimited file
#Test on only accepted names for iDigBio data
head -1 occurrence.csv > acceptednames.csv
cat occurrence.csv | grep "accepted" >> acceptednames.csv
./sciNameCount.sh acceptednames.csv NamesAccOccur.txt