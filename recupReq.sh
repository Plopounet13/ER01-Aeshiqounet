#! /bin/bash

LANG=C

if [ $# -ne 1 ]; then
	echo "Erreur nombre de parametres incorrect: nombre requis 1" 2>&1
	exit
fi

SEED=$1
RANDOM=$SEED
		
while read dico; do
	siz=$(wc -l < $dico)
	python3 genRand.py $SEED $siz | (while read line;do
		mot=$(sed "${line}q;d" $dico)
		curl -sA "Chrome" -L "http://www.google.com/search?hl=en&q=$mot" -o tmp.html
		nb=$(grep '<div class="sd" id="resultStats">' < tmp.html | sed -E 's/.*"resultStats">(About )?([1-9][0-9,]*) results.*/\2/' | sed 's/,//g')
		tmp=$(echo $nb | grep "doctype" | wc -l)
		if [ $tmp -ne 0 ]; then
			nb=0
		fi
		echo $mot\;${#mot}\;$nb\; >> $dico.out
	done)
	sleep 60
done < listeDico.txt

rm tmp.html