#!/bin/bash


for file in *.peaks

do 
cat $file
echo "This is $file"
sed 's/\([A-Z]\)\([0-9]*\)\(.*\)/\2 \1 \3/' $file > med_$file
awk '{ if($1!="A" && $1!="?-?") printf "%d\t%s\t%f\t%f\t%e\t%e\t%s\n", $1, $2, $4, $5, $6, $7, $8}' med_$file > Nessy_$file

rm med_$file


done

