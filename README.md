# ECN_backbone_taxonomies
Scripts and data files associated with Johnston and Franz 2017 Backbone Taxonomies, Data Aggregation, and Early Career Systematists: Something's got to give, presented at the Entomological Collections Network Annual Meeting, Denver, CO.

## Arizona Eleodes

The folder ArizonaEleodes contains the files analyzed for this talk to look at what species of Eleodes occur in the state of Arizona. ArizonaEleodes.zip contains the original downloaded data from iDigBio.

Enter directory in terminal, call the bash script as follows:
```
./sciNameCount.sh occurrence.csv OccurrenceNames.txt
```
This will result in the text file OccurrenceNames.txt with a count of all the strings in the scientificName field
```
head -1 occurrence.csv > acceptednames.csv
cat occurrence.csv | grep "accepted" >> acceptednames.csv
./genSpCount.sh acceptednames.csv AcceptedNamesCount.txt
```
This will result in the text file AcceptedNamesCount.txt with a count of all the accepted binomial genus/species names according to the backbone taxonomy.
Note: These scripts should work on any occurrence files downloaded from iDigBio or GBIF (or presumably any other darwin-core formatted text file).

## MAJC Eleodes

The folder GBIF_MAJC contains the files used to analyze the changes of my personal collection once harvested from SCAN by GBIF.
We can perform the same analysis as above.  However, GBIF's standardized data (occurrence.txt) is already filtered to only contain accepted names, so if we simply run the sciNameCount.sh script, we can get the accepted names from occurrence.txt, or we can run the script on the verbatim.txt file to obtain the equivalent of the scientificName count from iDigBio above.

```
./sciNameCount.sh occurrence.txt OccurrenceNames.txt
./sciNameCount.sh verbatim.txt VerbatimNames.txt
```
