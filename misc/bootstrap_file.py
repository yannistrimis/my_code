import numpy as np
import sys
sys.path.insert(0, '..')

from python_funcs import *

filename = input()

f1 = open("%s"%(filename),"r")

cont1 = f1.readlines()
nsamples = len(cont1)

f1.close()

arr1 = np.zeros(nsamples)

for i in range(nsamples):
  arr1[i] = float( cont1[i].strip() )

mean = 0
for el in arr1:
  mean = mean + el
mean = mean / nsamples

sdev = 0
for el in arr1:
  sdev = sdev + (el-mean)**2
sdev = sdev / nsamples
sdev = np.sqrt(sdev)

print( "%.6f\t%.6f"%(mean, sdev) )
