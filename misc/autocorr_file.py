import numpy as np
import sys
sys.path.insert(0, '..')

from python_funcs import *


filename = input()
str_nbins = input()
str_mctime = input()

fread = open("%s"%(filename),"r")
content = fread.readlines()
fread.close()

ndata = int( len(content) )
nbins = int( str_nbins )
ninbin = int( ndata/nbins )
mctime = int( str_mctime )

autoc = np.zeros(nbins)

for ibin in range(nbins):
  avg = 0.0
  for iline in range(ndata):
    if iline >= ibin*ninbin and iline < (ibin+1)*ninbin :
      continue
    else :
      avg = avg + float( content[iline].strip() )
  avg = avg / (ndata - ninbin)

  count = 0
  for iline in range(ndata):
    if (iline+mctime >= ibin*ninbin and iline < (ibin+1)*ninbin ) or iline+mctime >= ndata :
      continue
    else :
      count = count + 1
      autoc[ibin] = autoc[ibin] + ( float(content[iline].strip()) - avg ) * ( float(content[iline+mctime].strip()) - avg )

  autoc[ibin] = autoc[ibin] / count

autoc_avg, autoc_err = jackknife_for_binned(autoc)

print(autoc_avg, autoc_err)


"""
corr = 0.0
avg = 0.0

for iline in range(ndata):
  avg = avg + float( content[iline].strip() )
avg = avg / ndata

for iline in range(ndata):
  if iline+mctime < ndata :
    corr = corr + float( content[iline].strip() )*float( content[iline+mctime].strip() )
corr = corr / (ndata-mctime)

autoc = corr - avg**2

print(autoc)
"""
