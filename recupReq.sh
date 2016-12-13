#! /bin/bash

LANG=C

if [ $# -ne 2 ]; then
	echo "Erreur nombre de parametres incorrect: nombre requis 2 (SEED nbMots)" 2>&1
	exit
fi

SEED=$1
RANDOM=$SEED

		
while read dico; do
	siz=$(wc -l < $dico)
	python3 genRand.py $SEED $siz $2 > randoms.tmp
	i=0
	while read line;do
		i=$(($i+1))
		mot=$(sed "${line}q;d" $dico)
		curl -sA "Chrome" -L "http://www.google.com/search?hl=en&q=$mot" -o tmp.html
		nb=$(grep '<div class="sd" id="resultStats">' < tmp.html | sed -E 's/.*"resultStats">(About )?([1-9][0-9,]*) results.*/\2/' | sed 's/,//g')
		tmp=$(echo $nb | grep "doctype" | wc -l)
		if [ $tmp -ne 0 ]; then
			nb=0
		fi
		echo $mot\;${#mot}\;$nb\; >> $dico.out
		if [ i -e 50 ]; then
			sleep 30
			i=0
		fi
	done < randoms.tmp
	sleep 30
done < listeDico.txt

rm tmp.html