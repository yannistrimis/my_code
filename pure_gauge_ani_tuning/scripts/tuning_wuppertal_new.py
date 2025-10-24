import numpy as np
from matplotlib import pyplot as plt
import sys
sys.path.insert(0, '../..') # icer

from python_funcs import *

### THIS SCRIPT SETS THE w0 SCALE AND RENORMALIZED GAUGE ANISOTROPY
### FOR PURE GAUGES ENSEMBLES. IT ALSO PRODUCES JACKKNIFE-BINNED DATA
### WHICH ARE STORED IN FILE FOR PLOTTING.

w0phys = 0.17355

cur_dir = '/home/trimis/fnal/all/outputs'
write_dir = '/home/trimis/flow_data'

ens_pre = "1632f21b6396m014m070xig"

x0_vec = ["1000"]
x0_float_vec = [ 1.0 ]

ens_post="xiq1000a"

xf = "100"
xf_float = 1.0

flow_type = input()
obs_type = input()
check_single_ens = input() # THIS IS RELEVANT IF A SINGLE ENSEMBLE NEEDS TO
# BE CHECKED WRT LATTICE SPACING (w_0) AND RENORMALIZED ANISOTROPY (xi_g);
# IF xi_g IS CORRECTLY TUNED THEN THE RATIO w_0s/w_0t SHOULD BE 1.0 WITHIN ERRORS.
dt = '0.015625'
n_files = 700
first_file = 101
n_bins = 25
i_x0_rec = 0 # WHICH ONE OF THE BARE ANISOTROPIES TO PICK FOR RECORDING

f_write = open( '%s/data_%sflow%s%s%s_xf%s_dt%s_obs_%s'%(write_dir,flow_type,ens_pre,x0_vec[i_x0_rec],ens_post,xf,dt,obs_type) , 'w' )
f_write.write( '#tau #Et #Et_err #Es #Es_err #dEt #dEt_err #dEs #dEs_err #ratio #ratio_err\n' )

print( "observable: %s	data from:"%(obs_type) )

i_x0 = -1
for x0 in x0_vec :
    i_x0 += 1
    print('%s/l%s%s%s/%sflow%s%s%s_xf%s_dt%s'%(cur_dir,ens_pre,x0,ens_post,flow_type,ens_pre,x0,ens_post,xf,dt))
    for i_file in range(first_file,n_files+first_file):
        i = i_file - first_file
        f_read = open( '%s/l%s%s%s/%sflow%s%s%s_xf%s_dt%s.%d'%(cur_dir,ens_pre,x0,ens_post,flow_type,ens_pre,x0,ens_post,xf,dt,i_file) , 'r' )
        content = f_read.readlines()
        f_read.close()
        if i_file == first_file and i_x0 == 0 : ### WE DECLARE THE ARRAYS ONLY ONCE
            for i_line in range(len(content)):
                my_line = content[ i_line ].split(' ')
                if my_line[0] == 'Number' and my_line[2] == 'steps' :
                    n_steps = int(my_line[4])+1
            tau_arr = np.zeros( n_steps )
            Es_arr = np.zeros(( n_steps , n_files , len(x0_vec) ))
            Et_arr = np.zeros(( n_steps , n_files , len(x0_vec) ))
            dEs_arr = np.zeros(( n_steps , n_files , len(x0_vec) ))
            dEt_arr = np.zeros(( n_steps , n_files , len(x0_vec) ))
            ratio_arr = np.zeros(( n_steps , n_files , len(x0_vec) ))

        i_time = 0
        for i_line in range(len(content)):
            my_line = content[ i_line ].split(' ')
            if my_line[0] == 'RUNNING': # FOR SECURITY
                break
            if my_line[0] == 'GFLOW:' :
                if i_file == first_file and i_x0 == 0 : ### WE FORM tau_arr ONLY ONCE
                    tau_arr[i_time] = float( my_line[1] )
                if obs_type == 'clover' :
                    Et_arr[i_time,i,i_x0] = float( my_line[2] )
                    Es_arr[i_time,i,i_x0] = float( my_line[3] )
                elif obs_type == 'wilson' :
                    Et_arr[i_time,i,i_x0] = 6*( 3-float(my_line[6]) )
                    Es_arr[i_time,i,i_x0] = 6*( 3-float(my_line[7]) )
                elif obs_type == 'symanzik' :
                    Et_arr[i_time,i,i_x0] = 10*( 3-float(my_line[6]) )-( 3-float(my_line[8]) )
                    Es_arr[i_time,i,i_x0] = 10*( 3-float(my_line[7]) )-( 3-float(my_line[9]) )
                elif obs_type == 'i_clover' :
                    Et_arr[i_time,i,i_x0] = float( my_line[4] )
                    Es_arr[i_time,i,i_x0] = float( my_line[5] )
                Et_arr[i_time,i,i_x0] = tau_arr[i_time]*tau_arr[i_time]*Et_arr[i_time,i,i_x0]
                Es_arr[i_time,i,i_x0] = tau_arr[i_time]*tau_arr[i_time]*Es_arr[i_time,i,i_x0]
                i_time = i_time + 1

        dEt_arr[:,i,i_x0] = deriv( Et_arr[:,i,i_x0] , float(dt) )
        dEs_arr[:,i,i_x0] = deriv( Es_arr[:,i,i_x0] , float(dt) )

        for i_time in range(0,n_steps) :
            dEt_arr[i_time,i,i_x0] = xf_float**2 * dEt_arr[i_time,i,i_x0] * tau_arr[i_time]
            dEs_arr[i_time,i,i_x0] = dEs_arr[i_time,i,i_x0] * tau_arr[i_time]
            if i_time>0 :
                ratio_arr[i_time,i,i_x0] = (dEs_arr[i_time,i,i_x0])/(dEt_arr[i_time,i,i_x0]) # WE OMIT THE FIRST ELEMENT; DIVISION BY ZERO

### AT THIS STAGE dES AND dEt MEASUREMENT POINTS HAVE BEEN FORMED

dEs_binned = np.zeros( ( n_steps , n_bins , len(x0_vec) ) )
dEs_weight = np.zeros( ( n_steps , len(x0_vec) ) )

dEt_binned = np.zeros( ( n_steps , n_bins , len(x0_vec) ) )
dEt_weight = np.zeros( ( n_steps , len(x0_vec) ) )

for i_x0 in range(len(x0_vec)):
    for i_time in range(n_steps):
        dEs_binned[i_time,:,i_x0] = jackknife(dEs_arr[i_time,:,i_x0],n_bins,'bins')
        dEs_error = jackknife(dEs_arr[i_time,:,i_x0],n_bins,'error')
        dEt_binned[i_time,:,i_x0] = jackknife(dEt_arr[i_time,:,i_x0],n_bins,'bins')
        dEt_error = jackknife(dEt_arr[i_time,:,i_x0],n_bins,'error')

        if i_time > 0: # the first elements are not going to be needed anyways
            dEs_weight[i_time,i_x0] = 1/(dEs_error)
            dEt_weight[i_time,i_x0] = 1/(dEt_error)


### AT THIS STAGE dES AND dEt HAVE BEEN BINNED SO THAT JACKKNIFE PROCESS
### CAN BE APPLIED ON THEM. THE WEIGHTS (JACKKNIFE ERRORS APPLIED EQUIVALENTLY
### TO ALL BINS) WILL BE USED AS WEIGHTS IN THE FITS

for i_time in range(n_steps):
    Et_rec = jackknife(Et_arr[i_time,:,i_x0_rec],n_bins,'average')
    Et_err_rec = jackknife(Et_arr[i_time,:,i_x0_rec],n_bins,'error')
    Es_rec = jackknife(Es_arr[i_time,:,i_x0_rec],n_bins,'average')
    Es_err_rec = jackknife(Es_arr[i_time,:,i_x0_rec],n_bins,'error')
    dEt_rec = jackknife(dEt_arr[i_time,:,i_x0_rec],n_bins,'average')
    dEt_err_rec = jackknife(dEt_arr[i_time,:,i_x0_rec],n_bins,'error')
    dEs_rec = jackknife(dEs_arr[i_time,:,i_x0_rec],n_bins,'average')
    dEs_err_rec = jackknife(dEs_arr[i_time,:,i_x0_rec],n_bins,'error')
    ratio_rec = jackknife(ratio_arr[i_time,:,i_x0_rec],n_bins,'average')
    ratio_err_rec = jackknife(ratio_arr[i_time,:,i_x0_rec],n_bins,'error')
    f_write.write('%f %f %f %f %f %f %f %f %f %f %f\n'%(tau_arr[i_time],Et_rec,Et_err_rec,Es_rec,Es_err_rec,dEt_rec,dEt_err_rec,dEs_rec,dEs_err_rec,ratio_rec,ratio_err_rec))
f_write.close()

del Et_arr
del Es_arr
del dEt_arr
del dEs_arr

### AT THIS STAGE QUANTITES HAVE BEEN RECORDED FOR A SELECTED x0

w0s_arr = np.zeros( ( n_bins , len(x0_vec) ) )
w0t_arr = np.zeros( ( n_bins , len(x0_vec) ) )

w0s_weight = np.zeros( len(x0_vec) )
w0s_error = np.zeros( len(x0_vec) )

for i_x0 in range(len(x0_vec)):
    for i_bins in range(n_bins):
        y_points = np.zeros(7) # dEs_arr VALUES
        x_points = np.zeros(7) # tau_arr VALUES
        w_points = np.zeros(7) # WEIGHTS
        clos_i = closest( dEs_binned[:,i_bins,i_x0] , 0.15 )
        for j in range(7):
            k = -3+j
            y_points[j] = dEs_binned[clos_i+k,i_bins,i_x0]
            x_points[j] = tau_arr[clos_i+k]
            w_points[j] = dEs_weight[clos_i+k,i_x0]

        coeffs = np.polyfit(x_points,y_points,4,w=w_points)
        coeffs[4] = coeffs[4] - 0.15
        solutions = np.roots(coeffs)
        for ii in range( len(solutions) ): # FOR SECURITY
            if solutions[ii] < tau_arr[clos_i+1] and solutions[ii] > tau_arr[clos_i-1] :
                w0s_arr[i_bins,i_x0] = np.sqrt( np.real(solutions[ii]) )
                break
    w0s_weight[i_x0] = 1 / ( jackknife_for_binned(w0s_arr[:,i_x0])[1] )
    w0s_error[i_x0] = 1 /  w0s_weight[i_x0]

for i_x0 in range(len(x0_vec)):
    for i_bins in range(n_bins):
        y_points = np.zeros(7) # dEt_arr VALUES
        x_points = np.zeros(7) # tau_arr VALUES
        w_points = np.zeros(7) # WEIGHTS
        clos_i = closest( dEt_binned[:,i_bins,i_x0] , 0.15 )
        for j in range(7):
            k = -3+j
            y_points[j] = dEt_binned[clos_i+k,i_bins,i_x0]
            x_points[j] = tau_arr[clos_i+k]
            w_points[j] = dEt_weight[clos_i+k,i_x0]

        coeffs = np.polyfit(x_points,y_points,4,w=w_points)
        coeffs[4] = coeffs[4] - 0.15
        solutions = np.roots(coeffs)
        for ii in range( len(solutions) ): # FOR SECURITY
            if solutions[ii] < tau_arr[clos_i+1] and solutions[ii] > tau_arr[clos_i-1] :
                w0t_arr[i_bins,i_x0] = np.sqrt( np.real(solutions[ii]) )
                break

### AT THIS STAGE WE HAVE w0s AND w0t POINTS PER x0 PER BIN

ratios = np.zeros(( n_bins, len(x0_vec) ))
ratio_weights = np.zeros( len(x0_vec) )
ratio_errors = np.zeros( len(x0_vec) )

for i_x0 in range(len(x0_vec)):
    for i_bins in range(n_bins):
        ratios[i_bins,i_x0] = w0s_arr[i_bins,i_x0]/w0t_arr[i_bins,i_x0]
    ratio_weights[i_x0] = 1.0 / jackknife_for_binned(ratios[:,i_x0])[1]
    ratio_errors[i_x0] = 1.0 / ratio_weights[i_x0]
### AT THIS STAGE WE HAVE RATIO POINTS AND WEIGHTS PER x0 PER BIN


## The next two lines should be uncommented if one needs w_0 or ratio per x0.
## The first tuning stage plot in the aHISQ paper needed that, for example.
#    ratio_single_ens = jackknife_for_binned(ratios[:,i_x0])
#    print('xi_0 = %.4f    w_0s/w_0t = %.6f +- %.6f'%(x0_float_vec[i_x0], ratio_single_ens[0], ratio_single_ens[1]))

if check_single_ens == 'yes' :
    w0_single_ens = np.zeros(2)
    ratio_single_ens = np.zeros(2)

    w0_single_ens = jackknife_for_binned(w0s_arr[:,0])
    ratio_single_ens = jackknife_for_binned(ratios[:,0])
    print('FOR THIS ENSEMBLE:')
    print('w_0s = %.6f +- %.6f    w_0s/w_0t = %.6f +- %.6f'%(w0_single_ens[0],w0_single_ens[1],ratio_single_ens[0],ratio_single_ens[1]))
    a_s_mean = w0phys / w0_single_ens[0]
    a_s_sdev = ( w0phys / w0_single_ens[0]**2 ) * w0_single_ens[1]
    print('SPATIAL LATTICE SPACING:')
    print('a_s = %.6f +- %.6f'%(a_s_mean,a_s_sdev))
    sys.exit()

predicted_x0_binned = np.zeros(n_bins)
predicted_w0s_binned = np.zeros(n_bins)

for i_bins in range(n_bins):
    clos_i = closest(ratios[i_bins,:],1.0)
    point_list = []
    xpoints = np.zeros(3)
    ypoints = np.zeros(3)
    wpoints = np.zeros(3)
    if clos_i == len(x0_vec)-1:
        point_list = [clos_i-2,clos_i-1,clos_i]
    elif clos_i == 0:
        point_list = [clos_i,clos_i+1,clos_i+2]
    else:
        point_list = [clos_i-1,clos_i,clos_i+1]
    k = 0
    for point in point_list:
        xpoints[k] = x0_float_vec[point]
        ypoints[k] = ratios[i_bins,point]
        wpoints[k] = ratio_weights[point]
        k = k + 1

    coeffs1 = np.polyfit(x0_float_vec,ratios[i_bins,:],1,w=ratio_weights)
    coeffs1[1] = coeffs1[1] - 1.0
    solutions = np.roots(coeffs1)
    for ii in range( len(solutions) ): # FOR SECURITY
        if solutions[ii] < ( x0_float_vec[len(x0_float_vec)-1] + 0.5 ) and solutions[ii] > ( x0_float_vec[0] - 0.5 ) :
            predicted_x0_binned[i_bins] = np.real(solutions[ii])
            break

    k = 0
    for point in point_list:
        ypoints[k] = w0s_arr[i_bins,point]
        wpoints[k] = w0s_weight[point]
        k = k + 1
    coeffs2 = np.polyfit(x0_float_vec,w0s_arr[i_bins,:],1,w=w0s_weight)
    predicted_w0s_binned[i_bins] = np.polyval(coeffs2,predicted_x0_binned[i_bins])

predicted_x0 = jackknife_for_binned(predicted_x0_binned)
predicted_w0s = jackknife_for_binned(predicted_w0s_binned)

#f1 = plt.figure(1)
#for i_bins in range(n_bins):
#    plt.errorbar(x0_float_vec,ratios[i_bins,:],yerr=ratio_errors, fmt='.')
#    plt.axvline(x=predicted_x0_binned[i_bins], linestyle='-')


#f2 = plt.figure(2)
#for i_bins in range(n_bins):
#    plt.errorbar(x0_float_vec,w0s_arr[i_bins,:],yerr=w0s_error,fmt='.')
#    plt.axhline(y=predicted_w0s_binned[i_bins], linestyle='-')
#    plt.axvline(x=predicted_x0_binned[i_bins], linestyle='-')
#plt.show()

#input()

print( flow_type,obs_type,'x_0 = ',predicted_x0[0],' +- ',predicted_x0[1],'  w_0s = ',predicted_w0s[0],' +- ',predicted_w0s[1] )

