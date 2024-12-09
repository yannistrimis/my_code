import numpy as np
from scipy.optimize import curve_fit
from matplotlib import pyplot as plt

print('\n')

def func(x,a,b):
    return a+b*x

# INPUT
N_space = 16
x_ren = 1.5
N_of_x0 = 4
N_of_mom = 3

x0_arr=np.array([ 1.05, 1.25, 1.45, 1.65 ])

my_arr = np.array([\
[0.0,             0.646486, 0.000143,       0.566393, 0.000163,       0.507091, 0.000136,       0.460375, 0.000150],\
[1.0,             0.710117, 0.000246,       0.621976, 0.000205,       0.555709, 0.000205,       0.503321, 0.000156],\
[2.0,             0.767408, 0.000531,       0.671763, 0.000335,       0.600101, 0.000343,       0.542609, 0.000257]])

#ENDETH INPUT

for i in range(N_of_mom):
    my_arr[i,0]=my_arr[i,0]*((2*np.pi)/N_space)**2

    for j in range(N_of_x0):
        my_arr[i,2*j+2]=2*my_arr[i,2*j+1]*my_arr[i,2*j+2]
        my_arr[i,2*j+1]=my_arr[i,2*j+1]**2

x_arr=np.zeros((N_of_x0,3))

l = -1
for j in range(N_of_x0):

    l = l + 1
    p_mean, p_cov = curve_fit(func, my_arr[:,0], my_arr[:,2*j+1],sigma=my_arr[:,2*j+2])
    x_arr[l,0] = 1/np.sqrt(p_mean[1])
    x_arr[l,1] = 0.5*np.sqrt(p_cov[1,1])*x_arr[l,0]**3
    x_arr[l,2] = 1/(x_arr[l,1])

    print ('bare: %.2f  output: %.5f +- %.5f'%(x0_arr[l],x_arr[l,0],x_arr[l,1]) )

print('\n')

if N_of_x0 > 2 :

    coeffs = np.polyfit( x0_arr[:], x_arr[:,0], 2, w=x_arr[:,2] )
    coeffs[2] = coeffs[2] - x_ren
    solutions = np.roots(coeffs)

    for ii in range( len(solutions) ):
        if solutions[ii] < ( x_ren + 2.0 ) and solutions[ii] > ( x_ren - 2.0 ) :
            predicted_xq0  = np.real(solutions[ii])
            break

    print('predicted xq0: %.5f'%predicted_xq0)

    plt.errorbar(x0_arr[:],x_arr[:,0],yerr=x_arr[:,1],fmt='o')
    plt.show()
    print('\n')
