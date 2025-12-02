# 4 SPACES INSTEAD OF TAB
import numpy as np

ens_name = input()
pre_name = input()
i_file = input()
out_name = input()
out_dir = input()

# out_dir = '/mnt/home/trimisio/plot_data/spec_data' # ICER

# out_dir = '/project/ahisq/yannis_puregauge/spec_data' # FNAL

# out_dir = '/home/trimis/spec_data' # CMSE

f_write = open('%s/l%s/%s.%s'%(out_dir,ens_name,out_name,i_file),'w')
f_read_a = open('%s/l%s/%s.%sa'%(out_dir,ens_name,pre_name,i_file),'r')

content_a = f_read_a.readlines()

for i_line in range(len(content_a)) :
    re = 0.0
    im = 0.0

    split_a = content_a[i_line].split(' ')

    re =  float(split_a[1])
    im =  float(split_a[2])

    f_write.write('%s %.16f %.16f\n'%(split_a[0],re,im))

f_write.close()
f_read_a.close()

