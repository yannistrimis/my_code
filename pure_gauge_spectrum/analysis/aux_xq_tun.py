import numpy as np
from matplotlib import pyplot as plt

print('\n')

# INPUT
N_of_x0 = 4
N_of_mass = 4

mss_phys = 685.8 # MeV
hc = 197.327 # MeV * fm

a = 0.16 # fm
xi_g = 1.50

mss_lat = a * mss_phys / hc

x0_arr = np.array([ 1.05, 1.25, 1.45, 1.65 ])
mass_arr = np.array([ 0.03, 0.05, 0.07, 0.09 ])
x0_per_mass = np.array([ 1.23671, 1.23080, 1.22437, 1.21699 ])

my_arr = np.array([\
[0.377100, 0.000196,       0.334526, 0.000155,       0.302938, 0.000309,       0.277993, 0.000256],\
[0.483979, 0.000176,       0.427374, 0.000168,       0.385202, 0.000185,       0.351850, 0.000168],\
[0.570913, 0.000142,       0.502280, 0.000168,       0.450896, 0.000148,       0.410555, 0.000170],\
[0.646486, 0.000143,       0.566393, 0.000163,       0.507091, 0.000136,       0.460375, 0.000150]])

#ENDETH INPUT

my_arr_mean = np.zeros((N_of_mass,N_of_x0))
my_arr_sdev = np.zeros((N_of_mass,N_of_x0))
my_arr_weig = np.zeros((N_of_mass,N_of_x0))

for i_mass in range(N_of_mass) :
  for i_x0 in range(N_of_x0) :
    my_arr_mean[i_mass,i_x0] = xi_g * my_arr[i_mass,i_x0*2]
    my_arr_sdev[i_mass,i_x0] = xi_g * my_arr[i_mass,i_x0*2+1]
    my_arr_weig[i_mass,i_x0] = 1 / my_arr_sdev[i_mass,i_x0]

ss_per_mass = np.zeros(N_of_mass)

for i_mass in range(N_of_mass) :
  coeffs = np.polyfit( x0_arr, my_arr_mean[i_mass,:], 2, w=my_arr_weig[i_mass,:] )
  ss_per_mass[i_mass] = np.polyval( coeffs, x0_per_mass[i_mass] )
  print('m_s = ', mass_arr[i_mass],'    x0_quark = ', x0_per_mass[i_mass], '    m_ss = ', ss_per_mass[i_mass])

print('\ncorrect m_ss = ', mss_lat, '\n')

coeffs = np.polyfit( mass_arr, ss_per_mass, 2)

coeffs[2] = coeffs[2] - mss_lat
solutions = np.roots(coeffs)

for ii in range( len(solutions) ): # FOR SECURITY
  if solutions[ii] < 0.10 and solutions[ii] > 0.01 :
    m_quark = np.real(solutions[ii])
    break

coeffs = np.polyfit( mass_arr, x0_per_mass, 2)

xq_0 = np.polyval( coeffs, m_quark)

print('\nFINAL VALUES:  m_s = ',m_quark,'    xq_0 = ', xq_0, '\n')

















