import numpy as np
import sys
sys.path.insert(0, '../..')
from python_funcs import *
from scipy.optimize import curve_fit

# THIS SIMPLE SCRIPT IMPLEMENTS UNCORRELATED FIT
# ON 2-POINT STAGGERED HADRON CORRELATOR DATA.
# IT READS A FILE WITH AS MANY LINES AS MEASURED CONFIGURATIONS
# WITH EACH LINE STARTING WITH "PROP".

an_init = []
En_init = []

an_sqrt = []
dEn_sqrt = []

ao_init = []
Eo_init = []

ao_sqrt = []
dEo_sqrt = []


s = [0, 0]

# INPUT, START
corr_file = input()

str_nt = input()
nt = int(str_nt)

str_nof_n = input()
nof_n = int(str_nof_n)
if nof_n > 0 :

  str_sn = input()
  sn = float( str_sn )

for i_n in range(nof_n) :
  str_a = input()
  str_E = input()
  an_init.append( float(str_a) )
  En_init.append( float(str_E) )

str_nof_o = input()
nof_o = int(str_nof_o)
if nof_o > 0 :

  str_so = input()
  so = float( str_so )

for i_o in range(nof_o) :
  str_a = input()
  str_E = input()
  ao_init.append( float(str_a) )
  Eo_init.append( float(str_E) )

str_tmin = input()
str_tmax = input()

tmin = int(str_tmin)
tmax = int(str_tmax)
# INPUT, END

# CHECK OF INPUT, START
print("corr_file =",corr_file)
print("nt =",str_nt)

print("nof_n =", str_nof_n)
if nof_n > 0 :
  print("sn =",str_sn)
for i_n in range(nof_n) :
  print("an_init[%d] = %.4f"%(i_n,an_init[i_n]))
  print("En_init[%d] = %.4f"%(i_n,En_init[i_n]))

print("nof_o =", str_nof_o)
if nof_o > 0 :
  print("so =",str_so)
for i_o in range(nof_o) :
  print("ao_init[%d] = %.4f"%(i_o,ao_init[i_o]))
  print("Eo_init[%d] = %.4f"%(i_o,Eo_init[i_o]))

print("tmin =",str_tmin)
print("tmax =",str_tmax)
# CHECK OF INPUT, END

# INITIAL VALUES FOR ALL PARAMETERS
for i_n in range(nof_n) :
  an_sqrt.append( np.sqrt( an_init[i_n] ) )
  if i_n == 0 :
    dEn_sqrt.append( np.sqrt( En_init[i_n] ) )
  elif i_n > 0 :
    dEn_sqrt.append( np.sqrt( En_init[i_n]-En_init[0] ) )

for i_o in range(nof_o) :
  ao_sqrt.append( np.sqrt( ao_init[i_o] ) )
  if i_o == 0 :
    dEo_sqrt.append( np.sqrt( Eo_init[i_o] ) )
  elif i_o > 0 :
    dEo_sqrt.append( np.sqrt( Eo_init[i_o]-Eo_init[0] ) )


# GENERIC FIT FUNCTION DEFINITION
def generic_fitfcn(t,*fitparams) :
  res = 0.0
  i_params = -2
  En = 0.0
  Eo = 0.0
  for i_n in range(nof_n) :
    i_params = i_params + 2
    an = fitparams[i_params]**2
    En = En + fitparams[i_params+1]**2
    res = res + sn*an*( np.exp(-En*t) + np.exp(-En*nt+En*t) )
  for i_o in range(nof_o) :
    i_params = i_params + 2
    ao = fitparams[i_params]**2
    Eo = Eo + fitparams[i_params+1]**2
    res = res + so*np.cos(np.pi*t)*ao*( np.exp(-Eo*t) + np.exp(-Eo*nt+Eo*t) )
  return res

# PART TO-BE-MODIFIED (SPECIFIC FIT FUNCTION AND INITIAL PARAMETERS), START
def fitfcn(t,an0_sqrt,dEn0_sqrt) :
  return generic_fitfcn(t,an0_sqrt,dEn0_sqrt)

flaglist = [] # If e.g. ao[0] IS TO BE KEPT FIXED THEN 2 MUST BE IN flaglist.
param_init = [an_sqrt[0], dEn_sqrt[0]]
# PART TO-BE-MODIFIED, END

nof_params = len(param_init)

# DATA EXTRACTION
f_read = open("%s"%(corr_file),"r")
content = f_read.readlines()
f_read.close()

n_conf = len(content)

full_data_arr = np.zeros((n_conf,int(nt/2)+1))

for i_line in range(n_conf) :
  line = content[i_line]
  line = line.strip()
  line = line.split(" ")
  for it in range(int(nt/2)+1) :
    full_data_arr[i_line,it] = float(line[it+1] )

tfit_data_arr = np.zeros((n_conf,tmax-tmin+1))

for i_conf in range(n_conf) :
  it_shift = -1
  for it in range(tmin,tmax+1) :
    it_shift = it_shift + 1
    tfit_data_arr[i_conf,it_shift] = full_data_arr[i_conf,it]

# MEANS AND ERRORS FOR DATA POINTS
data_arr = np.zeros((tmax-tmin+1,2))

for it in range(tmax-tmin+1) :
  for i_conf in range(n_conf) :
    data_arr[it,0] = data_arr[it,0] + tfit_data_arr[i_conf,it]
  data_arr[it,0] = data_arr[it,0] / n_conf

  err = 0.0
  for i_conf in range(n_conf) :
    err = err + ( tfit_data_arr[i_conf,it] - data_arr[it,0] )**2
  err = err / ( n_conf**2 - n_conf )
  err = np.sqrt(err)
  data_arr[it,1] = err

t_vector = np.linspace(tmin,tmax,num=tmax-tmin+1)

# FIT
pmean, pcov, infodict, mesg, ier = curve_fit( fitfcn, t_vector, data_arr[:,0], p0=param_init, sigma=data_arr[:,1], full_output=True )

dof = tmax-tmin + 1 - nof_params

fit_arr = np.zeros(tmax-tmin+1)
it_shift = -1
for it in range(tmin,tmax+1) :
  it_shift = it_shift + 1
  fit_arr[it_shift] = fitfcn(it, *pmean)


chisq_bydof = chisq_by_dof_uncorr(data_arr[:,0],fit_arr,data_arr[:,1],dof)
qval = q_value(chisq_bydof,dof)

print("\nCHI^2/DOF =", chisq_bydof, "  Q_VAL =", qval, "  DOF =", dof)
print("\n")
print("#t data data_sdev fit residuals")
it_shift = -1
for it in range(tmin,tmax+1) :
  it_shift = it_shift + 1
  resid = ( fitfcn(it, *pmean) - data_arr[it_shift,0] ) / data_arr[it_shift,1]
  print(it, data_arr[it_shift,0], data_arr[it_shift,1], fitfcn(it, *pmean), resid )
print("\n")
print("NUMBER OF FIT FUNCTION CALLS =", infodict["nfev"])
print(mesg)

param_result = np.zeros( 2*nof_n+ 2*nof_o )

