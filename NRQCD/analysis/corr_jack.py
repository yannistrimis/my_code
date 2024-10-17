import numpy as np
import sys
sys.path.insert(0, '../..')
from python_funcs import *

name = input()

nt = 35
n_bins = 10

f_read = open('%s.specdata'%(name),'r')
content = f_read.readlines()
n_of_files = len(content)

if (n_of_files%n_bins) != 0 :
    print('WARNING: number of bins does not divide number of files')

tau_arr = np.zeros(nt)
for i in range(nt) :
    tau_arr[i] = i

f_read.close()

write_1_re = open('%s.specdata.bins'%(name),'w')
write_2_re = open('%s.specdata.averr'%(name),'w')

my_bin_array_re = np.zeros(( nt , n_bins ))
my_array_re = np.zeros(( nt , n_of_files ))
my_av_re = np.zeros(nt)
my_err_re = np.zeros(nt)

print(n_of_files,nt)

for j in range(n_of_files) :
    line = content[j].split(' ')
    print(len(line))
    for i in range(nt) :
        my_array_re[i,j] =  float(line[i+1])

for i in range(nt) :
    my_bin_array_re[i,:] = jackknife(my_array_re[i,:],n_bins,'bins')
    my_av_re[i] = jackknife(my_array_re[i,:],n_bins,'average')    
    my_err_re[i] = jackknife(my_array_re[i,:],n_bins,'error')
 
for i in range(nt) :
    write_1_re.write( '%d '%(tau_arr[i]) )
    write_2_re.write( '%d '%(tau_arr[i]) )

    write_2_re.write( '%.16f %.16f\n'%(my_av_re[i],my_err_re[i]) )

    for j in range(n_bins-1) :
        write_1_re.write('%.16f '%(my_bin_array_re[i,j]))

    write_1_re.write('%.16f\n'%(my_bin_array_re[i,n_bins-1]))
   

write_1_re.close()
write_2_re.close()

