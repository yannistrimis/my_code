import numpy as np
from scipy.optimize import curve_fit
from matplotlib import pyplot as plt

print('\n')

def func(x,a,b):
    return a+b*x

# INPUT
N_space = 16
x_ren = 2.0
N_of_x0 = 3
N_of_mom = 3

x0_arr=np.array([ 1.88, 1.94, 2.00 ])

my_arr = np.array([[0.00, 0.25910, 0.00024, 0.25464, 0.00024, 0.25040, 0.00023],\
[1.00, 0.32913, 0.00051, 0.32342, 0.00049, 0.31798, 0.00048],\
[2.00, 0.38523, 0.00083, 0.37851, 0.00079, 0.37209, 0.00076]])

#ENDETH INPUT

for i in range(N_of_mom):
    my_arr[i,0]=my_arr[i,0]*((2*np.pi)/N_space)**2

    for j in range(N_of_x0):
        my_arr[i,2*j+2]=2*my_arr[i,2*j+1]*my_arr[i,2*j+2]
        my_arr[i,2*j+1]=my_arr[i,2*j+1]**2

x_arr=np.zeros((N_of_x0,2))

l = -1
for j in range(N_of_x0):

    l = l + 1
    p_mean, p_cov = curve_fit(func, my_arr[:,0], my_arr[:,2*j+1],sigma=my_arr[:,2*j+2])
    x_arr[l,0] = 1/np.sqrt(p_mean[1])
    x_arr[l,1] = 0.5*np.sqrt(p_cov[1,1])*x_arr[l,0]**3
    print ('bare: %.2f  output: %.5f +- %.5f'%(x0_arr[l],x_arr[l,0],x_arr[l,1]) )

print('\n')

if N_of_x0 > 2 :

    coeffs = np.polyfit( x0_arr[:], x_arr[:,0], 2, w=x_arr[:,1] )
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
