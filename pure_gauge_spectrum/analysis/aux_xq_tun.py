import numpy as np
from matplotlib import pyplot as plt

print('\n')

# INPUT
N_of_x0 = 3
N_of_mass = 4

mss_phys = 685.8 # MeV
hc = 197.327 # MeV * fm

a = 0.16 # fm
xi_g = 1.5

mss_lat = a * mss_phys / hc

x0_arr = np.array([ 1.0, 1.2, 1.4 ])
mass_arr = np.array([ 0.05, 0.07, 0.09 ])
x0_per_mass = np.array([ 1.19510, 1.19559, 1.19447 ])

my_arr = np.array([\
[0.415365, 0.000686,       0.375605, 0.000646,       0.345529, 0.000518],\
[0.491793, 0.000542,       0.443484, 0.000504,       0.406975, 0.000446],\
[0.559310, 0.000509,       0.503046, 0.000450,       0.460540, 0.000400]])

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

















