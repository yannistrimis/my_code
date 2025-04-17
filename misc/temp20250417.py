import numpy as np

# The following computes xi0 and beta for a_sigma = 0.16 fm
# and xi = 1.1. The input data pairs are (all three) for a_sigma = 0.16 fm.

x_arr = [1.0, 1.5, 2.0]
beta_arr = [6.81823, 6.94635, 7.04115]
xi0_arr = [1.0, 1.39939, 1.81411]

x_target = 1.1

coeffs_beta = np.polyfit(x_arr, beta_arr, 2)

beta_pred = np.polyval(coeffs_beta, x_target)

coeffs_xi0 = np.polyfit(x_arr, xi0_arr, 2)

xi0_pred = np.polyval(coeffs_xi0, x_target)

print(beta_pred)
print(xi0_pred)
