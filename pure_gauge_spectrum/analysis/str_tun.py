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
a = 0.20 # fm
xi_ren = 2.00

my_arr = np.array([\
[0.08,    0.304105,        0.000193],\
[0.09,    0.322527,        0.000186],\
[0.10,    0.340166,        0.000176],\
[0.11,    0.357080,        0.000172],\
])
# END OF INPUT


mss_lat = a * mss_phys / hc

pmean, pcov = curve_fit( func, my_arr[:,0], xi_ren*my_arr[:,1], sigma=xi_ren*my_arr[:,2] )

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
print(ms)
plt.show()
