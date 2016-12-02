import sys
from random import *

if len(sys.argv)!=3:
	print("Erreur: Nombre de parametres incorrect (2 attendu)", file=sys.stderr)
	exit()

seed(int(sys.argv[1]))

for i in range(1,51):
	print(randint(1, int(sys.argv[2])))
