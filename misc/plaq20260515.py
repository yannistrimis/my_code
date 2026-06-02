import sys
sys.path.insert(0, '..')

from python_funcs import *
import numpy as np

xi = input()
ssfilename = input()
stfilename = input()

nbins = 50

ss_read = open( '%s'%(ssfilename) , 'r' )
ss_content = ss_read.readlines()
ss_read.close()

st_read = open( '%s'%(stfilename) , 'r' )
st_content = st_read.readlines()
st_read.close()

ss_arr = np.zeros(len(ss_content))
st_arr = np.zeros(len(ss_content))

for i in range(len(ss_content)):
  ss_arr[i] = float(ss_content[i].strip())
  st_arr[i] = float(st_content[i].strip())


ss_jackarr = jackknife(ss_arr,nbins,'bins')
st_jackarr = jackknife(st_arr,nbins,'bins')

quant_ss_jackarr = np.zeros(nbins)
quant_st_jackarr = np.zeros(nbins)

for i in range(nbins):
  quant_ss_jackarr[i] = np.sqrt( ss_jackarr[i] )
  quant_st_jackarr[i] = np.sqrt( st_jackarr[i]*st_jackarr[i]/ss_jackarr[i] )

quant_ss_avg, quant_ss_err = jackknife_for_binned(quant_ss_jackarr)
quant_st_avg, quant_st_err = jackknife_for_binned(quant_st_jackarr)

ss_avg , ss_err = jackknife_for_binned(ss_jackarr)
st_avg , st_err = jackknife_for_binned(st_jackarr)

print("%s %f %f %f %f %f %f %f %f"%(xi, ss_avg, ss_err, st_avg, st_err, quant_ss_avg, quant_ss_err, quant_st_avg, quant_st_err))
