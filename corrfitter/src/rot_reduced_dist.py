import numpy as np

cov_file  = input()
fit_file = input()


# --------------------------------------------------
# 1. Read covariance matrix
# --------------------------------------------------

data = np.loadtxt(cov_file)

values = data[:, 1]

N = int(np.sqrt(len(values)))

if N * N != len(values):
    raise ValueError("Number of covariance elements is not a perfect square!")

# Reconstruct covariance matrix
cov_matrix = values.reshape(N, N)


# --------------------------------------------------
# 2. Cholesky decomposition
# --------------------------------------------------

L = np.linalg.cholesky(cov_matrix)


# --------------------------------------------------
# 3. Read vector from data file
# --------------------------------------------------

data_vector = np.loadtxt(fit_file, comments="#")

# Last column contains the vector. But we multiply by sdev of data because we divided it out in the script
# that produces the outputs! Think about it!
v = data_vector[:, -1] * data_vector[:, 2]

# Check dimensions
if len(v) != N:
    raise ValueError(
        f"Vector has {len(v)} elements, but matrix dimension is {N}"
    )


# --------------------------------------------------
# 4. Calculate w = L^(-1) v
# --------------------------------------------------

w = np.linalg.solve(L, v)

# --------------------------------------------------
# 5. Print resulting vector
# --------------------------------------------------

print("Transformed vector w:")

for i in range(N):
    print(data_vector[i, 0], w[i])


