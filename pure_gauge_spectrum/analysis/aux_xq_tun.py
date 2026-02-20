import numpy as np
from matplotlib import pyplot as plt

print('\n')

# INPUT
N_of_x0 = 3
N_of_mass = 3

mss_phys = 685.8 # MeV
hc = 197.327 # MeV * fm

a = 0.16 # fm
xi_g = 8.0

mss_lat = a * mss_phys / hc

x0_arr = np.array([ 7.47, 7.87, 8.27 ])
mass_arr = np.array([ 0.060803, 0.070803, 0.080803 ])
x0_per_mass = np.array([ 7.90159, 7.90416, 8.00342 ])

my_arr = np.array([\
[0.066512, 0.000059,        0.064663, 0.000059,       0.062925, 0.000056],\
[0.071795, 0.000057,        0.069747, 0.000056,       0.067846, 0.000054],\
[0.076753, 0.000054,        0.074532, 0.000053,       0.072489, 0.000052]])

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
  if solutions[ii] < 0.1 and solutions[ii] > 0.01 :
    m_quark = np.real(solutions[ii])
    break

coeffs = np.polyfit( mass_arr, x0_per_mass, 2)

xq_0 = np.polyval( coeffs, m_quark)

print('\nFINAL VALUES:  m_s = ',m_quark,'    xq_0 = ', xq_0, '\n')

















