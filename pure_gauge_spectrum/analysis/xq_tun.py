# my_arr contains N_of_mom rows and N_of_x0 + 1 columns.
# Its first column is p^2.

import numpy as np
from scipy.optimize import curve_fit
from matplotlib import pyplot as plt


print('\n')

def func(x,a,b):
    return a+b*x

# INPUT
N_space = 16
x_ren = 1.2
N_of_x0 = 3
N_of_mom = 3

x0_arr=np.array([ 1.0, 1.2, 1.4 ])

my_arr = np.array([\
[0.0,             0.415365, 0.000686,       0.375605, 0.000646,       0.345529, 0.000518],\
[1.0,             0.550255, 0.001133,       0.497202, 0.000933,       0.455880, 0.000605],\
[2.0,             0.662206, 0.003553,       0.596866, 0.002494,       0.546493, 0.001877]])

#ENDETH INPUT

N_boot = 10000

xq0_arr = np.zeros(N_boot)

for i_boot in range(N_boot):
  znorm = np.random.normal(0.0,1.0)
  my_arr_boot = np.zeros(( N_of_mom, 2*N_of_x0+1 ))

  for i in range(N_of_mom):
    my_arr_boot[i,0]=my_arr[i,0]*((2*np.pi)/N_space)**2

    for j in range(N_of_x0):
      sigma = my_arr[i,2*j+2]
      mu = my_arr[i,2*j+1]

      norm = znorm * sigma + mu

      my_arr_boot[i,2*j+2] = 2 * norm  * sigma
      my_arr_boot[i,2*j+1] = norm ** 2

  x_arr=np.zeros((N_of_x0,3))

  l = -1
  for j in range(N_of_x0):

    l = l + 1
    p_mean, p_cov = curve_fit(func, my_arr_boot[:,0], my_arr_boot[:,2*j+1],sigma=my_arr_boot[:,2*j+2])
    x_arr[l,0] = 1/np.sqrt(p_mean[1])
    x_arr[l,1] = 0.5*np.sqrt(p_cov[1,1])*x_arr[l,0]**3
    x_arr[l,2] = 1/(x_arr[l,1])

#    print ('bare: %.2f  output: %.5f +- %.5f'%(x0_arr[l],x_arr[l,0],x_arr[l,1]) )

#  print('\n')

  if N_of_x0 > 2 :

    coeffs = np.polyfit( x0_arr[:], x_arr[:,0], 2, w=x_arr[:,2] )
    coeffs[2] = coeffs[2] - x_ren
    solutions = np.roots(coeffs)

    for ii in range( len(solutions) ):
      if solutions[ii] < ( x_ren + 2.0 ) and solutions[ii] > ( x_ren - 2.0 ) :
        predicted_xq0  = np.real(solutions[ii])
        break

    xq0_arr[i_boot] = predicted_xq0

#    print('predicted xq0: %.5f'%predicted_xq0)

#    plt.errorbar(x0_arr[:],x_arr[:,0],yerr=x_arr[:,1],fmt='o')
#    plt.show()
#    print('\n')

xq0_avg = 0.0
sqdiff = 0.0

for i_boot in range(N_boot):
  xq0_avg = xq0_avg + xq0_arr[i_boot]
xq0_avg = xq0_avg / N_boot

for i_boot in range(N_boot):
  sqdiff = sqdiff + ( xq0_arr[i_boot] - xq0_avg )**2

xq0_sdv = np.sqrt( sqdiff / (N_boot-1) )

print( "xq0 +- d(xq0) = %.6f +- %.6f"%(xq0_avg,xq0_sdv) )
