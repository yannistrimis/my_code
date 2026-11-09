import numpy as np
from scipy.optimize import curve_fit
from scipy.special import gammainc

# Input parameters
Nn = int(input())
No = int(input())
tper = int(input())

sn = np.fromstring(input(), sep=" ") # Expect 1 or -1
so = np.fromstring(input(), sep=" ") # Expect 1 or -1

mult = int(input())
thin = int(input()) # Normal is 1. Greater than 1 if thinned

if Nn > 0:
    an = np.fromstring(input(), sep=" ")
    En = np.fromstring(input(), sep=" ")
else:
    an = np.array([])
    En = np.array([])

if No > 0:
    ao = np.fromstring(input(), sep=" ")
    Eo = np.fromstring(input(), sep=" ")
else:
    ao = np.array([])
    Eo = np.array([])

tmin = int(input())
tmax = int(input())

corr_flag = input() # Expect correlated or uncorrelated

data_file = input()

output_style = input() # Expect full_output or partial_output

# Fit function
def make_func(Nn, No, tper, sn, so):
    def fit_func(t, *p):
#        an = np.array(p[:Nn])
#        En = np.array(p[Nn:2*Nn])
#        ao = np.array(p[2*Nn:2*Nn+No])
#        Eo = np.array(p[2*Nn+No:])

        logan = np.array(p[:Nn])
        logEn = np.array(p[Nn:2*Nn])
        logao = np.array(p[2*Nn:2*Nn+No])
        logEo = np.array(p[2*Nn+No:])


        fn = 0
        for i in range(Nn):
            fn += sn[i] * np.exp(logan[i]) * (
                np.exp( -t * np.exp(logEn[i]) )
                + np.exp( (t-tper) * np.exp(logEn[i]) )
            )

        fo = 0
        for i in range(No):
            fo += so[i] * np.exp(logao[i]) * (
                np.exp( -t * np.exp(logEo[i]) )
                + np.exp( (t-tper) * np.exp(logEo[i]) )
            )

        return fn + (-1)**t * fo

    return fit_func


fit_func = make_func(Nn, No, tper, sn, so)



# Read data: skip the PROP label on each line
with open(data_file) as file:
    y = np.array([
        np.fromstring(line.strip().split("PROP", 1)[1], sep=" ")
        for line in file
        if line.strip().startswith("PROP")
    ])

Ndata = y.shape[0]

# Select fit range
tdata = np.arange(tmin, tmax + 1, thin)
ysamples = mult * y[:, tmin:tmax + 1:thin]

ydata = np.mean(ysamples, axis=0)

# Covariance matrix is built from the partial data set.
Cov = np.cov(ysamples, rowvar=False, ddof=1) / Ndata
Uncov = np.sqrt(np.diag(Cov))

p0 = np.log( np.concatenate([an, En, ao, Eo]) )

# Correlated fit or Uncorrelated fit.

if corr_flag == "uncorrelated":
    popt, pcov, infodict, mesg, ier = curve_fit(
        fit_func,
        tdata,
        ydata,
        p0=p0,
        sigma=Uncov,
        absolute_sigma=True,
        full_output=True
    )
    residuals = ydata - fit_func(tdata, *popt)
    chisq = np.sum((residuals / Uncov)**2)

elif corr_flag == "correlated":
    popt, pcov, infodict, mesg, ier = curve_fit(
        fit_func,
        tdata,
        ydata,
        p0=p0,
        sigma=Cov,
        absolute_sigma=True,
        full_output=True
    )
    residuals = ydata - fit_func(tdata, *popt)
    chisq = residuals.T @ np.linalg.inv(Cov) @ residuals
else:
    raise ValueError("corr_flag must be 'uncorrelated' or 'correlated'")

errors = np.sqrt(np.diag(pcov))
dof = len(ydata) - len(popt)

qval = 1 - gammainc(0.5*dof, 0.5*chisq)

# print results
if output_style == "full_output":

    print("\nFitting data from:", data_file)
    print("\nwith: tmin =",tmin,"  tmax =",tmax)

    print("\n\nFit termination message:", mesg)
    print("Termination status:", ier)
    print("Number of function evaluations:", infodict["nfev"])

    print("\n\nInitial guesses:")

    for i in range(Nn):
        print("an[%d] = %.6f"%(i, np.exp(p0[i]) )         )
        print("En[%d] = %.6f"%(i, np.exp(p0[Nn+i]) )      )

    for i in range(No):
        print("ao[%d] = %.6f"%(i, np.exp(p0[2*Nn+i]) )    )
        print("Eo[%d] = %.6f"%(i, np.exp(p0[2*Nn+No+i]) ) )

    print("\nFitted parameters and errors:")

    for i in range(Nn):
        print("an[%d] = %.6f +/- %.6f"%(i, np.exp(popt[i]),           np.exp(popt[i])*errors[i]) )
        print("En[%d] = %.6f +/- %.6f"%(i, np.exp(popt[Nn+i]),        np.exp(popt[Nn+i])*errors[Nn+i]) )

    for i in range(No):
        print("ao[%d] = %.6f +/- %.6f"%(i, np.exp(popt[2*Nn+i]),          np.exp(popt[2*Nn+i])*errors[2*Nn+i]) )
        print("Eo[%d] = %.6f +/- %.6f"%(i, np.exp(popt[2*Nn+No+i]),       np.exp(popt[2*Nn+No+i])*errors[2*Nn+No+i]) )

    print("\nchi-square/dof =", chisq/dof, "   dof =", dof, "   qval=", qval)

elif output_style == "partial_output":

    print("%d %d %.6f %d %.6f"%(tmin, tmax, chisq/dof, dof, qval), end="")
    for i in range(Nn):
        print(" an[%d]: %.6f %.6f"%( i, np.exp(popt[i]),    np.exp(popt[i])*errors[i] ), end="")
        print(" En[%d]: %.6f %.6f"%( i, np.exp(popt[Nn+i]), np.exp(popt[Nn+i])*errors[Nn+i] ), end="")
    for i in range(No):
        print(" ao[%d]: %.6f %.6f"%( i, np.exp(popt[2*Nn+i]),    np.exp(popt[2*Nn+i])*errors[2*Nn+i] ), end="")
        print(" Eo[%d]: %.6f %.6f"%( i, np.exp(popt[2*Nn+No+i]), np.exp(popt[2*Nn+No+i])*errors[2*Nn+No+i] ), end="")
    print("\n", end="")

"""

# The following is just a consistency test. The two covariance matrices should coincide.

ovmat = np.zeros(( len(ydata), len(ydata) ))

for i in range(len(ydata)):
    for j in range(len(ydata)):
        for iconf in range(Ndata):
            covmat[i,j] = covmat[i,j] + ( ysamples[iconf,i] - ydata[i] ) * ( ysamples[iconf,j] - ydata[j] )
        covmat[i,j] = covmat[i,j] / ( Ndata**2 - Ndata )

print("Covariance matrix from numpy is:")
print(Cov)
print("Covariance matrix from definition is:")
print(covmat)

"""
