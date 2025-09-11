import numpy as np
from scipy.optimize import curve_fit
from matplotlib import pyplot as plt

xi = 2.0

my_arr = np.array([\
[0.016624,        0.000009],\
[0.041353,        0.000020],\
[0.046682,        0.000052],\
[0.061930,        0.000081],\
[0.065022,        0.000058],\
[0.079070,        0.000142],\
[0.078638,        0.000169]])

c4_05 = xi**2 * float(my_arr[0,0])
c4_i5 = float(my_arr[1,0])
c4_ij = xi**2 / (xi**2+1) * float(my_arr[2,0])
c4_i0 = 1/2 * float(my_arr[3,0])
c4_i  = xi**2 / (2*xi**2+1) * float(my_arr[4,0])
c4_0  = 1/3 * float(my_arr[5,0])
c4_s  = xi**2 / (3*xi**2+1) * float(my_arr[6,0])

dc4_05 = xi**2 * float(my_arr[0,1])
dc4_i5 = float(my_arr[1,1])
dc4_ij = xi**2 / (xi**2+1) * float(my_arr[2,1])
dc4_i0 = 1/2 * float(my_arr[3,1])
dc4_i  = xi**2 / (2*xi**2+1) * float(my_arr[4,1])
dc4_0  = 1/3 * float(my_arr[5,1])
dc4_s  = xi**2 / (3*xi**2+1) * float(my_arr[6,1])

print(c4_05,dc4_05)
print(c4_i5,dc4_i5)
print(c4_ij,dc4_ij)
print(c4_i0,dc4_i0)
print(c4_i,dc4_i)
print(c4_0,dc4_0)
print(c4_s,dc4_s)
