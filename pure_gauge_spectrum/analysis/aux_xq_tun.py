import numpy as np
from matplotlib import pyplot as plt

print('\n')

# INPUT
N_of_x0 = 3
N_of_mass = 3

mss_phys = 685.8 # MeV
hc = 197.327 # MeV * fm

a = 0.16 # fm
xi_g = 2.0

mss_lat = a * mss_phys / hc

x0_arr = np.array([ 1.2, 1.6, 2.0 ])
mass_arr = np.array([ 0.025, 0.035, 0.045 ])
x0_per_mass = np.array([ 1.55401, 1.54767, 1.54421 ])

my_arr = np.array([\
[0.272902, 0.000168,       0.227170, 0.000153,       0.197902, 0.000137],\
[0.322346, 0.000140,       0.267086, 0.000129,       0.231842, 0.000124],\
[0.365628, 0.000134,       0.301599, 0.000122,       0.260851, 0.000115]])

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

















