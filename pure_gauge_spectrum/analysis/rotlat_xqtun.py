
import numpy as np
from scipy.optimize import curve_fit
import sys
sys.path.insert(0, '../..')

from python_funcs import *

def func(x,a,b):
    return a*x+b


nbins = 40
x0_arr = [1.84, 1.92, 2.00]

x0_predicted_arr = np.zeros(nbins)

E0a_arr = np.zeros((nbins,6))
E0z_arr = np.zeros((nbins,6))

xq_az_arr = np.zeros((nbins,6))

fa1_read = open("/home/yannis/Physics/LQCD/spec_data/l1664b704115x181411a/tunp000cw1664b704115x181411xq1840_m0.07m0.07PION_5.1p0.bin1.free.jackfit","r")
fa2_read = open("/home/yannis/Physics/LQCD/spec_data/l1664b704115x181411a/tunp000cw1664b704115x181411xq1920_m0.07m0.07PION_5.1p0.bin1.free.jackfit","r")
fa3_read = open("/home/yannis/Physics/LQCD/spec_data/l1664b704115x181411a/tunp000cw1664b704115x181411xq2000_m0.07m0.07PION_5.1p0.bin1.free.jackfit","r")

fz1_read = open("/home/yannis/Physics/LQCD/spec_data/l1664b704115x181411z/tunp000cw1664b704115x181411xq1840_m0.07m0.07PION_5.1p0.bin1.free.jackfit","r")
fz2_read = open("/home/yannis/Physics/LQCD/spec_data/l1664b704115x181411z/tunp000cw1664b704115x181411xq1920_m0.07m0.07PION_5.1p0.bin1.free.jackfit","r")
fz3_read = open("/home/yannis/Physics/LQCD/spec_data/l1664b704115x181411z/tunp000cw1664b704115x181411xq2000_m0.07m0.07PION_5.1p0.bin1.free.jackfit","r")

a1_content = fa1_read.readlines()
a2_content = fa2_read.readlines()
a3_content = fa3_read.readlines()

z1_content = fz1_read.readlines()
z2_content = fz2_read.readlines()
z3_content = fz3_read.readlines()


fa1_read.close()
fa2_read.close()
fa3_read.close()

fz1_read.close()
fz2_read.close()
fz3_read.close()

for i_bin in range(40) :

  a1_content[i_bin] = a1_content[i_bin].strip()
  a2_content[i_bin] = a2_content[i_bin].strip()
  a3_content[i_bin] = a3_content[i_bin].strip()

  z1_content[i_bin] = z1_content[i_bin].strip()
  z2_content[i_bin] = z2_content[i_bin].strip()
  z3_content[i_bin] = z3_content[i_bin].strip()


for i_bin in range(40) :

  line_a1 = a1_content[i_bin].split(" ")
  line_a2 = a2_content[i_bin].split(" ")
  line_a3 = a3_content[i_bin].split(" ")

  line_z1 = z1_content[i_bin].split(" ")
  line_z2 = z2_content[i_bin].split(" ")
  line_z3 = z3_content[i_bin].split(" ")



  E0a_arr[i_bin,0] = float(line_a1[0])
  E0a_arr[i_bin,1] = float(line_a1[1])
  E0a_arr[i_bin,2] = float(line_a2[0])
  E0a_arr[i_bin,3] = float(line_a2[1])
  E0a_arr[i_bin,4] = float(line_a3[0])
  E0a_arr[i_bin,5] = float(line_a3[1])

  E0z_arr[i_bin,0] = float(line_z1[0])
  E0z_arr[i_bin,1] = float(line_z1[1])
  E0z_arr[i_bin,2] = float(line_z2[0])
  E0z_arr[i_bin,3] = float(line_z2[1])
  E0z_arr[i_bin,4] = float(line_z3[0])
  E0z_arr[i_bin,5] = float(line_z3[1])

  xq_az_arr[i_bin,0] = E0z_arr[i_bin,0] / E0a_arr[i_bin,0]
  xq_az_arr[i_bin,2] = E0z_arr[i_bin,2] / E0a_arr[i_bin,2]
  xq_az_arr[i_bin,4] = E0z_arr[i_bin,4] / E0a_arr[i_bin,4]

  xq_az_arr[i_bin,1] = np.sqrt( ( E0z_arr[i_bin,1] / E0a_arr[i_bin,0] )**2 + ( E0a_arr[i_bin,1]*E0z_arr[i_bin,0] / E0a_arr[i_bin,0]**2 )**2 )
  xq_az_arr[i_bin,3] = np.sqrt( ( E0z_arr[i_bin,3] / E0a_arr[i_bin,2] )**2 + ( E0a_arr[i_bin,3]*E0z_arr[i_bin,2] / E0a_arr[i_bin,2]**2 )**2 )
  xq_az_arr[i_bin,5] = np.sqrt( ( E0z_arr[i_bin,5] / E0a_arr[i_bin,4] )**2 + ( E0a_arr[i_bin,5]*E0z_arr[i_bin,4] / E0a_arr[i_bin,4]**2 )**2 )

  points = np.zeros((3,2))

  points[0,0] = xq_az_arr[i_bin,0]
  points[0,1] = xq_az_arr[i_bin,1]
  points[1,0] = xq_az_arr[i_bin,2]
  points[1,1] = xq_az_arr[i_bin,3]
  points[2,0] = xq_az_arr[i_bin,4]
  points[2,1] = xq_az_arr[i_bin,5]

  pmean, pcov = curve_fit( func, x0_arr, points[:,0], sigma=points[:,1] )

  pmean[1] = pmean[1] - 2.00

  x0_predicted_arr[i_bin] = np.roots(pmean)

x0_predicted = jackknife_for_binned(x0_predicted_arr)
print("predicted x0: ", x0_predicted[0], " +- ", x0_predicted[1])
