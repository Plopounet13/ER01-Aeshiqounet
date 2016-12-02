#! /bin/bash
files=$(ls 42/)
echo $files
for i in {42..47};
do
	for j in $files;
	do
		cat $i/$j >> concat/$j
	done;
done;
