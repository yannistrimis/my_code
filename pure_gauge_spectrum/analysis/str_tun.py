import numpy as np
from scipy.optimize import curve_fit
from matplotlib import pyplot as plt

def func(x,a,b,c):
    return a*x*x+b*x+c

# PARAMS
# w0_phys = 0.17355
mss_phys = 685.8
hc = 197.327
# END OF PARAMS

# INPUT
a = 0.16 # fm
xi_ren = 4.00

nof_mass = 5

my_arr = np.array([\
[0.03, 0.090399, 0.000103],\
[0.05, 0.115819, 0.000104],\
[0.07, 0.136741, 0.000105],\
[0.09, 0.155160, 0.000104],\
[0.11, 0.172010, 0.000096],\
])

N_boot = 10000

# END OF INPUT

mss_lat = a * mss_phys / hc
ms_arr = np.zeros(N_boot)

for i_boot in range(N_boot):
  znorm = np.random.normal(0.0,1.0)
  my_arr_boot = np.zeros((nof_mass,3))

  for imass in range(nof_mass):
    my_arr_boot[imass,0] = my_arr[imass,0]
    sigma = my_arr[imass,2]
    mu = my_arr[imass,1]

    norm = znorm * sigma + mu

    my_arr_boot[imass,2] = sigma
    my_arr_boot[imass,1] = norm

  pmean, pcov = curve_fit( func, my_arr_boot[:,0], xi_ren*my_arr_boot[:,1], sigma=xi_ren*my_arr_boot[:,2] )

  if i_boot == 0 :
    x_vec = np.linspace(0,0.13,num=50)
    y_vec = np.zeros(50)

    for ix in range(len(x_vec)):
      y_vec[ix] = func(x_vec[ix],pmean[0],pmean[1],pmean[2])

    plt.errorbar(my_arr[:,0],xi_ren*my_arr[:,1],yerr=xi_ren*my_arr[:,2],fmt='o')
    plt.plot(x_vec,y_vec)

  coeffs = [pmean[0],pmean[1],pmean[2]]
  coeffs[2] = coeffs[2] - mss_lat

  ms = 0.0
  solutions = np.roots(coeffs)
  for ii in range( len(solutions) ): # FOR SECURITY
    if solutions[ii] <  0.2  and solutions[ii] >  0.01  :
      ms = np.real(solutions[ii])
      break
  ms_arr[i_boot] = ms

ms_avg = 0.0
sqdiff = 0.0

for i_boot in range(N_boot):
  ms_avg = ms_avg + ms_arr[i_boot]
ms_avg = ms_avg / N_boot

for i_boot in range(N_boot):
  sqdiff = sqdiff + ( ms_arr[i_boot] - ms_avg )**2

ms_sdv = np.sqrt( sqdiff / (N_boot-1) )

print( "N_boot = %d, ms +- d(ms) = %.6f +- %.6f"%(N_boot, ms_avg,ms_sdv) )
plt.show()
