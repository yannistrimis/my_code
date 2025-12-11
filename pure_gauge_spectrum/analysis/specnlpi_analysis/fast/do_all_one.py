import numpy as np

ens_name = input()
pre_name = input()
i_file = input()
mom = input()
mass1 = input()
mass2 = input()
source1 = input()
source2 = input()
sinkop1 = input()
sinkop2 = input()
sinks = input()
out_name = input()
cur_dir = input()
out_dir = input()
str_nt = input()

nt = int(str_nt)
# cur_dir = '/mnt/home/trimisio/outputs/pure_gauge_spec' # ICER
# out_dir = '/mnt/home/trimisio/plot_data/spec_data' # ICER

# cur_dir = '/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec' # FNAL
# out_dir = '/project/ahisq/yannis_puregauge/spec_data' # FNAL

# cur_dir = '/home/trimis/fnal/all/outputs/pure_gauge_spec' # CMSE --> FNAL
# out_dir = '/home/trimis/spec_data' # CMSE

f_read = open('%s/l%s_outputs/%s.%s'%(cur_dir,ens_name,pre_name,i_file),'r')

line_arr_a = []
line_arr_b = []

content = f_read.readlines()
f_read.close()

source_flag = 0
flag = -1
counter = 0

mom_line = 'MOMENTUM:' + ' ' + mom
mass_line = 'MASSES:' + ' ' + mass1 + ' ' + mass2 + ' '
source_line = 'SOURCE:' + ' ' + source1 + ' ' +  source2
sinkops_line = 'SINKOPS:' + ' ' + sinkop1 + ' ' + sinkop2
sink_line = 'SINKS:' + ' ' + sinks

for line in content:
        split_line = line.split(' ')
        if split_line[0]=='#' and split_line[1]=='source' and split_line[2]=='time':
                source_flag = source_flag + 1

        if line.rstrip('\n') == 'STARTPROP' :
                flag = 0
        elif flag==0 and line.rstrip('\n')==mom_line :
                flag = 1
        elif flag==1 and line.rstrip('\n')==mass_line :
                flag = 2
        elif flag==2 and line.rstrip('\n')==source_line :
                flag = 3
        elif flag==3 and line.rstrip('\n')==sinkops_line :
                flag = 4
        elif flag==4 and line.rstrip('\n')==sink_line :
                flag = 5
        elif flag==5 and split_line[0]=='0' :
                flag = 6
                counter = 1
                if source_flag == 1 :
                        line_arr_a.append(line)
                elif source_flag == 2 :
                        line_arr_b.append(line)
        elif flag==6 and split_line[0]==str(counter) :
                counter = counter + 1
                if source_flag == 1 :
                        line_arr_a.append(line)
                elif source_flag == 2 :
                        line_arr_b.append(line)
        elif flag==6 and line.rstrip('\n')=='ENDPROP' :
                flag = -1
                counter = 0

line_arr = []

for i_line in range(len(line_arr_a)) :
    re = 0.0
    im = 0.0

    split_a = line_arr_a[i_line].split(' ')
    split_b = line_arr_b[i_line].split(' ')

    re = 0.5*( float(split_a[1]) + float(split_b[1]) )
    im = 0.5*( float(split_a[2]) + float(split_b[2]) )

    appline = split_a[0] + ' ' + str(re) + ' ' + str(im)
    line_arr.append(appline)

fold_arr = np.zeros((int(nt/2)+1,3))
ind_fold = -1
re = 0.0
im = 0.0
foldflag = 0
for i_line in range(len(line_arr)) :
    split = line_arr[i_line].split(' ')
    if split[0] == '0' :
        re = float(split[1])
        im = float(split[2])
        foldflag = 1
        ind_fold += 1
        fold_arr[ind_fold,0] = float(split[0])
        fold_arr[ind_fold,1] = re
        fold_arr[ind_fold,2] = im
    elif split[0] == str(int(nt/2)) :
        re = float(split[1])
        im = float(split[2])
        foldflag = 0
        ind_fold += 1
        fold_arr[ind_fold,0] = float(split[0])
        fold_arr[ind_fold,1] = re
        fold_arr[ind_fold,2] = im
    elif foldflag == 1 :
        split2 = line_arr[ i_line+nt-2*int(split[0]) ].split(' ')
        re = ( float(split[1]) + float(split2[1]) ) / 2
        im = ( float(split[2]) + float(split2[2]) ) / 2
        ind_fold += 1
        fold_arr[ind_fold,0] = float(split[0])
        fold_arr[ind_fold,1] = re
        fold_arr[ind_fold,2] = im

f_write = open('%s/l%s/%s.specdata'%(out_dir,ens_name,out_name),'a')
f_write.write( 'PROP' )
for ind in range(int(nt/2)+1) :
    f_write.write( ' %.12f'%(fold_arr[ind,1]) )
f_write.write('\n')
f_write.close()
