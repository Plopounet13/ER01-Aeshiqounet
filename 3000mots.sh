#! /bin/bash

LANG=C

if [ $# -ne 1 ]; then
	echo "Erreur nombre de parametres incorrect: nombre requis 1 (SEED)" 2>&1
	exit
fi

for i in `seq 1 60`; do
	echo "Vague $i"
    ./recupReq.sh $1
    sleep 60
done  