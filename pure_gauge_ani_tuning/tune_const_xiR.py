import numpy as np

# REMEMBER TO TWEAK xi_g_target, nof_betas AND ORDER OF FIT POLYNOMIAL

filename = input()

w0_phys = 0.17355
a = 0.081

w0_target = w0_phys/a
xi_g_target = 4.0

nof_betas = 4
f1 = open("%s"%(filename),"r")

f1_content = f1.readlines()

arr = np.zeros((nof_betas,5))

for i in range(nof_betas):

    line = f1_content[i].split('\t')
    rest_of_line = line[1].split(' ')

    beta_str = line[0]
    beta = float(beta_str)

    xi0_str = rest_of_line[0]
    dxi0_str = rest_of_line[1]
    xi0 = float(xi0_str)
    dxi0 = float(dxi0_str)

    w0_str = rest_of_line[2]
    dw0_str = rest_of_line[3].rstrip()
    w0 = float(w0_str)
    dw0 = float(dw0_str)

    arr[i,0] = beta
    arr[i,1] = xi0
    arr[i,2] = 1/dxi0**2
    arr[i,3] = w0
    arr[i,4] = 1/dw0**2

beta_points = arr[:,0]
xi_points = arr[:,1]
xi_weights = arr[:,2]
w0_points = arr[:,3]
w0_weights = arr[:,4]

coeffs_w0 = np.polyfit(beta_points,w0_points,2,w=w0_weights)
coeffs_w0[2] = coeffs_w0[2] - w0_target
solutions = np.roots(coeffs_w0)

for ii in range( len(solutions) ): # FOR SECURITY
    if solutions[ii] < ( beta_points[nof_betas-1] + 0.5 ) and solutions[ii] > ( beta_points[0] - 0.5 ) :
        my_beta = np.real(solutions[ii])
        break

coeffs_xi = np.polyfit(beta_points,xi_points,2,w=xi_weights)
my_xi0 = np.polyval(coeffs_xi,my_beta)

print('xi_0 = %.6f    beta = %.6f\n'%(my_xi0,my_beta))
