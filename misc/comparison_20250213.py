import numpy as np
from matplotlib import pyplot as plt
import sys
sys.path.insert(0, '..')

from python_funcs import *

n_bins = 20

filename = input()
f_read = open(filename, "r")
content = f_read.readlines()
f_read.close()

my_array = np.zeros(len(content))

for i_line in range(len(content)) :
  line = content[i_line]
  stripline = line.strip()
  splitline = stripline.split(" ")
  my_array[i_line] = float(splitline[1])

avg = jackknife(my_array,n_bins,"average")
sdv = jackknife(my_array,n_bins,"error")

print(avg,"+/-",sdv)
