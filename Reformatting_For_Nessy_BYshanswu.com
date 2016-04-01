#!/bin/bash


# This script is used to convert Sparky formatted peaklists into the peak lists that are identifiable by NESSY CPMG fitting software;
# The files with the *.peaks in the format of Sparky system should be stored in the working directory as the input files;
# The output files will be named in the pattern as Nessy_ + original filename. For instance, the file named "Bruker_1_CPMG.peaks" will 
# lead to the file named "Nessy_Bruker_1_CPMG.peaks"
# The scripts work in Bourne Shell
# shanswu20160331######



for file in *.peaks

do 
cat $file
echo "This is $file"
sed 's/\([A-Z]\)\([0-9]*\)\(.*\)/\2 \1 \3/' $file > med_$file
awk '{ if($1!="A" && $1!="?-?") printf "%d\t%s\t%f\t%f\t%e\t%e\t%s\n", $1, $2, $4, $5, $6, $7, $8}' med_$file > Nessy_$file

rm med_$file


done

