#!/bin/sh

python makewrap/extractFunctions.py makewrap/list_of_functions.txt functions.pickle --input cephes/bessel --input cephes/cprob --input cephes/misc --input cephes/polyn --input cephes/cmath --input cephes/ellf

python makewrap/createFFI.py functions.pickle
python makewrap/createTests.py functions.pickle

