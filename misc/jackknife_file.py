import numpy as np
import sys
sys.path.insert(0, '..')

from python_funcs import *

filename = input()
str_nbins = input()

nbins = int( str_nbins )
f1 = open("%s"%(filename),"r")

cont1 = f1.readlines()

f1.close()

arr1 = np.zeros(len(cont1))

for i in range(len(cont1)):
  arr1[i] = float( cont1[i].strip() )

aver1 = jackknife(arr1, nbins, "average")
stdv1 = jackknife(arr1, nbins, "error")

print( "%.6f\t%.6f"%(aver1, stdv1) )
