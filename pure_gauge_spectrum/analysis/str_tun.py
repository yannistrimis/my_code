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
xi_ren = 8.00

my_arr = np.array([ [0.05,    0.058482,        0.000072],\
[0.06,    0.063990,        0.000069],\
[0.07,    0.069099,        0.000066],\
[0.08,    0.073900,        0.000064] ])
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
