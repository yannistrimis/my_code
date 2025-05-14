import numpy as np
import sys
sys.path.insert(0, '..')

from python_funcs import *

f1 = open("/project/ahisq/yannis_dyn/outputs/l832f2b5350m021xig35xiq35a/misc.pbp.rescaled.20250514.temp","r")
f2 = open("/project/ahisq/yannis_dyn/outputs/l1624f2b5300m024xig30xiq30a/misc.pbp.rescaled.20250514.temp","r")

cont1 = f1.readlines()
cont2 = f2.readlines()

f1.close()
f2.close()

arr1 = np.zeros(len(cont1))
arr2 = np.zeros(len(cont2))

for i in range(len(cont1)):
  arr1[i] = float( cont1[i].strip() )

for i in range(len(cont2)):
  arr2[i] = float( cont2[i].strip() )


aver1 = jackknife(arr1, 20, "average")
stdv1 = jackknife(arr1, 20, "error")

aver2 = jackknife(arr2, 25, "average")
stdv2 = jackknife(arr2, 25, "error")

print(aver1,"+/-",stdv1)
print(aver2,"+/-",stdv2)
