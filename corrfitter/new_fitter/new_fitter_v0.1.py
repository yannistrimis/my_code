import numpy as np
import sys
sys.path.insert(0, '../..')
from python_funcs import *

# THIS SIMPLE SCRIPT IMPLEMENTS UNCORRELATED FIT
# ON 2-POINT STAGGERED HADRON CORRELATOR DATA.
# IT READS A FILE WITH AS MANY LINES AS MEASURED CONFIGURATIONS
# WITH EACH LINE STARTING WITH "PROP".

an_init = []
En_init = []

ao_init = []
Eo_init = []

s = [0, 0]

# INPUT START
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
# INPUT END

# PROOF OF INPUT START
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
# PROOF OF INPUT END

# FIT FUNCTION DEFINITION
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

def fitfcn_1p0(t,an_sqrt,dEn_sqrt) :
  return generic_fitfcn(t,an_sqrt,dEn_sqrt)

f_read = open("%s"%(corr_file),"r")
content = f_read.readlines()
f_read.close()

n_conf = len(content)

full_data_arr = np.zeros((n_conf,int(nt/2)+1))

for i_line in range(n_conf) :
  line = content[i_line]
  line = line.strip()
  line = line.split(" ")
  for i_t in range(int(nt/2)+1) :
    full_data_arr[i_line,i_t] = float(line[i_t+1] )

tfit_data_arr = np.zeros((n_conf,tmax-tmin+1))

for i_conf in range(n_conf) :
  i_t_shift = -1
  for i_t in range(tmin,tmax+1) :
    i_t_shift = i_t_shift + 1
    tfit_data_arr[i_conf,i_t_shift] = full_data_arr[i_conf,i_t]

print(tfit_data_arr)

data_arr = np.zeros((tmax-tmin+1,2))
