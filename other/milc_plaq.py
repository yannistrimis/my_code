import numpy as np
from matplotlib import pyplot as plt
import sys
sys.path.insert(0, '../') # icer

from python_funcs import *

filename = input()

plaq_st = np.zeros(300)
plaq_ss = np.zeros(300)

i_arr = -1
for i_file in range(101,401):
  f_read = open("%s.%d"%(filename, i_file), "r")
  content = f_read.readlines()
  f_read.close()
  flag = 0
  for line in content:
    strip_line = line.strip()
    split_line = strip_line.split(" ")
    if split_line[0] == "CHECK" and split_line[1] == "PLAQ:":
      if flag == 0:
        flag = 1
      else:
        flag = 0
        i_arr = i_arr + 1
#        print(i_arr,i_file)
        plaq_st[i_arr] = split_line[2]
        plaq_ss[i_arr] = split_line[3]

plaq_st_av = jackknife(plaq_st,30,"average")
plaq_st_sdev = jackknife(plaq_st,30,"error")

plaq_ss_av = jackknife(plaq_ss,30,"average")
plaq_ss_sdev = jackknife(plaq_ss,30,"error")

print(plaq_st_av,plaq_st_sdev,plaq_ss_av,plaq_ss_sdev)
