import numpy as np
import sys
sys.path.insert(0, '../..')

from python_funcs import *

filename = input()
str_lat_nt = input()
str_n_bins = input()

n_bins = int(str_n_bins)
lat_nt = int(str_lat_nt)

nt = int(lat_nt/2)+1 # QUICK SOLUTION FOR FOLDED DATA


f_read = open('%s'%(filename),'r')
content = f_read.readlines()
n_of_files = len(content)

if (n_of_files%n_bins) != 0 :
    print('WARNING: number of bins does not divide number of files')

tau_arr = np.zeros(nt)
for i in range(nt) :
    tau_arr[i] = i

f_read.close()

write_1_re = open('%s.bin'%(filename),'w')
write_2_re = open('%s.averr'%(filename),'w')


my_bin_array_re = np.zeros(( nt , n_bins ))
my_jackbin_array_re = np.zeros(( nt , n_bins ))


my_array_re = np.zeros(( nt , n_of_files ))
my_av_re = np.zeros(nt)
my_err_re = np.zeros(nt)

for j in range(n_of_files) :
    line = content[j].split(' ')
    for i in range(nt) :
        my_array_re[i,j] =  float(line[i+1])

for i in range(nt) :
    my_bin_array_re[i,:] = jackknife(my_array_re[i,:],n_bins,'normal_bins')
    my_jackbin_array_re[i,:] = jackknife(my_array_re[i,:],n_bins,'bins')

    my_av_re[i] = jackknife(my_array_re[i,:],n_bins,'average')    
    my_err_re[i] = jackknife(my_array_re[i,:],n_bins,'error')
 
for i in range(nt) :
    write_2_re.write( '%d %.16f %.16f\n'%(tau_arr[i],my_av_re[i],my_err_re[i]) )

for i_bin in range(n_bins) :
    write_1_re.write('PROP')
    for i in range(nt) :
        write_1_re.write( ' %.16f'%my_bin_array_re[i,i_bin] )
    write_1_re.write('\n')
   

write_1_re.close()
write_2_re.close()

for i_bin in range(n_bins) :
    write_jackbin = open('%s.jackbin_%d'%(filename,i_bin),'w')
    for i in range(nt) :
        write_jackbin.write('%.16f\n'%(my_jackbin_array_re[i,i_bin]))
    write_jackbin.close()
