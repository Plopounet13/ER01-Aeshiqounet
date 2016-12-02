#! /bin/bash

ls $1 |(while read file; do
	sed -e "s/;/,/g" -i .tmp $1/$file
	sed -e "s/,$//g" -i .tmp $1/$file
	echo "nom,tailleMot,nbResults" > $1/$file.tmp
	more $1/$file >> $1/$file.tmp
	cp $1/$file.tmp $1/$file
	rm $1/$file.tmp
done)


