import numpy as np
import sys
sys.path.insert(0, '../..') # icer

from python_funcs import *

### THIS SCRIPT SETS THE w0 SCALE AND RENORMALIZED GAUGE ANISOTROPY
### FOR PURE GAUGES ENSEMBLES

w0phys = 0.17355

# cur_dir = '/home/trimis/fnal/all/outputs'
# write_dir = '/home/trimis/fnal/all/flow_data'

# cur_dir = '/home/trimis/hpcc/outputs'
# write_dir = '/home/trimis/hpcc/flow_data'

# cur_dir = '/home/yannis/Physics/LQCD/fnal/all/outputs'
# write_dir = '/home/yannis/Physics/LQCD/fnal/all/flow_data'

cur_dir = "/home/trimisio/all/outputs"

ens_pre = "1632b687348x"

x0 = "115792"
x0_float = 1.15792

ens_post = "a"

xf_vec = ["115", "120", "125"]
xf_float_vec = [1.15, 1.20, 1.25]

flow_type = input()
obs_type = input()

dt = '0.015625'
n_files = 200
first_file = 101
n_bins = 20

f_write = open( '%s/data_%sflow%s%s%s_xf%s_dt%s_obs_%s'%(write_dir,flow_type,ens_pre,x0_vec[i_x0_rec],ens_post,xf,dt,obs_type) , 'w' )
f_write.write( '#tau #Et #Et_err #Es #Es_err #dEt #dEt_err #dEs #dEs_err #ratio #ratio_err\n' )

i_xf = -1
for xf in xf_vec :
    i_xf += 1
    for i_file in range(first_file,n_files+first_file):
        i = i_file - first_file
        f_read = open( '%s/l%s%s%s/%sflow%s%s%s_xf%s_dt%s.%d'%(cur_dir,ens_pre,x0,ens_post,flow_type,ens_pre,x0,ens_post,xf,dt,i_file) , 'r' )
        content = f_read.readlines()
        f_read.close()
        if i_file == first_file and i_xf == 0 : ### WE DECLARE THE ARRAYS ONLY ONCE
            for i_line in range(len(content)):
                my_line = content[ i_line ].split(' ')
                if my_line[0] == 'Number' and my_line[2] == 'steps' :
                    n_steps = int(my_line[4])+1
            tau_arr = np.zeros( n_steps )
            Es_arr = np.zeros(( n_steps , n_files , len(xf_vec) ))
            Et_arr = np.zeros(( n_steps , n_files , len(xf_vec) ))
            dEs_arr = np.zeros(( n_steps , n_files , len(xf_vec) ))
            dEt_arr = np.zeros(( n_steps , n_files , len(xf_vec) ))
            ratio_arr = np.zeros(( n_steps , n_files , len(xf_vec) ))

        i_time = 0
        for i_line in range(len(content)):
            my_line = content[ i_line ].split(' ')
            if my_line[0] == 'RUNNING': # FOR SECURITY
                break
            if my_line[0] == 'GFLOW:' :
                if i_file == first_file and i_xf == 0 : ### WE FORM tau_arr ONLY ONCE
                    tau_arr[i_time] = float( my_line[1] )
                if obs_type == 'clover' :
                    Et_arr[i_time,i,i_xf] = float( my_line[2] )
                    Es_arr[i_time,i,i_xf] = float( my_line[3] )
                elif obs_type == 'wilson' :
                    Et_arr[i_time,i,i_xf] = 6*( 3-float(my_line[6]) )
                    Es_arr[i_time,i,i_xf] = 6*( 3-float(my_line[7]) )
                elif obs_type == 'symanzik' :
                    Et_arr[i_time,i,i_xf] = 10*( 3-float(my_line[6]) )-( 3-float(my_line[8]) )
                    Es_arr[i_time,i,i_xf] = 10*( 3-float(my_line[7]) )-( 3-float(my_line[9]) )
                elif obs_type == 'i_clover' :
                    Et_arr[i_time,i,i_xf] = float( my_line[4] )
                    Es_arr[i_time,i,i_xf] = float( my_line[5] )
                Et_arr[i_time,i,i_xf] = tau_arr[i_time]*tau_arr[i_time]*Et_arr[i_time,i,i_xf]
                Es_arr[i_time,i,i_xf] = tau_arr[i_time]*tau_arr[i_time]*Es_arr[i_time,i,i_xf]
                i_time = i_time + 1

        dEt_arr[:,i,i_xf] = deriv( Et_arr[:,i,i_xf] , float(dt) )
        dEs_arr[:,i,i_xf] = deriv( Es_arr[:,i,i_xf] , float(dt) )

        for i_time in range(0,n_steps) :
            dEt_arr[i_time,i,i_xf] = xf_float**2 * dEt_arr[i_time,i,i_xf] * tau_arr[i_time]
            dEs_arr[i_time,i,i_xf] = dEs_arr[i_time,i,i_xf] * tau_arr[i_time]
            if i_time>0 :
                ratio_arr[i_time,i,i_xf] = (dEs_arr[i_time,i,i_xf])/(dEt_arr[i_time,i,i_xf]) # WE OMIT THE FIRST ELEMENT; DIVISION BY ZERO


### AT THIS STAGE dES AND dEt MEASUREMENT POINTS HAVE BEEN FORMED

dEs_binned = np.zeros( ( n_steps , n_bins , len(xf_vec) ) )
dEs_weight = np.zeros( ( n_steps , len(xf_vec) ) )

dEt_binned = np.zeros( ( n_steps , n_bins , len(xf_vec) ) )
dEt_weight = np.zeros( ( n_steps , len(xf_vec) ) )

for i_xf in range(len(xf_vec)):
    for i_time in range(n_steps):
        dEs_binned[i_time,:,i_xf] = jackknife(dEs_arr[i_time,:,i_xf],n_bins,'bins')
        dEs_error = jackknife(dEs_arr[i_time,:,i_xf],n_bins,'error')
        dEt_binned[i_time,:,i_xf] = jackknife(dEt_arr[i_time,:,i_xf],n_bins,'bins')
        dEt_error = jackknife(dEt_arr[i_time,:,i_xf],n_bins,'error')

        if i_time > 0: # the first elements are not going to be needed anyways
            dEs_weight[i_time,i_xf] = 1/(dEs_error)
            dEt_weight[i_time,i_xf] = 1/(dEt_error)

### AT THIS STAGE dES AND dEt HAVE BEEN BINNED SO THAT JACKKNIFE PROCESS
### CAN BE APPLIED ON THEM. THE WEIGHTS (JACKKNIFE ERRORS APPLIED EQUIVALENTLY
### TO ALL BINS) WILL BE USED AS WEIGHTS IN THE FITS

del Et_arr
del Es_arr
del dEt_arr
del dEs_arr

w0s_arr = np.zeros( ( n_bins , len(xf_vec) ) )
w0t_arr = np.zeros( ( n_bins , len(xf_vec) ) )

w0s_weight = np.zeros( len(xf_vec) )

for i_xf in range(len(xf_vec)):
    for i_bins in range(n_bins):
        y_points = np.zeros(7) # dEs_arr VALUES
        x_points = np.zeros(7) # tau_arr VALUES
        w_points = np.zeros(7) # WEIGHTS
        clos_i = closest( dEs_binned[:,i_bins,i_xf] , 0.15 )
        for j in range(7):
            k = -3+j
            y_points[j] = dEs_binned[clos_i+k,i_bins,i_xf]
            x_points[j] = tau_arr[clos_i+k]
            w_points[j] = dEs_weight[clos_i+k,i_xf]

        coeffs = np.polyfit(x_points,y_points,2,w=w_points)
        coeffs[2] = coeffs[2] - 0.15
        solutions = np.roots(coeffs)
        for ii in range( len(solutions) ): # FOR SECURITY
            if solutions[ii] < tau_arr[clos_i+1] and solutions[ii] > tau_arr[clos_i-1] :
                w0s_arr[i_bins,i_xf] = np.real(solutions[ii])
                break
    w0s_weight[i_xf] = 1 / ( jackknife_for_binned(w0s_arr[:,i_xf])[1] )

for i_xf in range(len(xf_vec)):
    for i_bins in range(n_bins):
        y_points = np.zeros(7) # dEt_arr VALUES
        x_points = np.zeros(7) # tau_arr VALUES
        w_points = np.zeros(7) # WEIGHTS
        clos_i = closest( dEt_binned[:,i_bins,i_xf] , 0.15 )
        for j in range(7):
            k = -3+j
            y_points[j] = dEt_binned[clos_i+k,i_bins,i_xf]
            x_points[j] = tau_arr[clos_i+k]
            w_points[j] = dEt_weight[clos_i+k,i_xf]

        coeffs = np.polyfit(x_points,y_points,2,w=w_points)
        coeffs[2] = coeffs[2] - 0.15
        solutions = np.roots(coeffs)
        for ii in range( len(solutions) ): # FOR SECURITY
            if solutions[ii] < tau_arr[clos_i+1] and solutions[ii] > tau_arr[clos_i-1] :
                w0t_arr[i_bins,i_xf] = np.real(solutions[ii])
                break

### AT THIS STAGE WE HAVE w0s AND w0t POINTS PER xf PER BIN

ratios = np.zeros(( n_bins, len(xf_vec) ))
ratio_weights = np.zeros( len(xf_vec) )

for i_xf in range(len(xf_vec)):
    for i_bins in range(n_bins):
        ratios[i_bins,i_xf] = w0s_arr[i_bins,i_xf]/w0t_arr[i_bins,i_xf]
    ratio_weights[i_xf] = 1.0 / jackknife_for_binned(ratios[:,i_xf])[1]

### AT THIS STAGE WE HAVE RATIO POINTS AND WEIGHTS PER xf PER BIN

predicted_xf_binned = np.zeros(n_bins)
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
        xpoints[k] = xf_float_vec[point]
        ypoints[k] = ratios[i_bins,point]
        wpoints[k] = ratio_weights[point]
        k = k + 1

    coeffs = np.polyfit(xpoints,ypoints,1,w=wpoints)
    coeffs[1] = coeffs[1] - 1.0
#    coeffs = np.polyfit(x0_float_vec,ratios[i_bins,:],3,w=ratio_weights)
#    coeffs[3] = coeffs[3] - 1.0
    solutions = np.roots(coeffs)
    for ii in range( len(solutions) ): # FOR SECURITY
        if solutions[ii] < ( xf_float_vec[len(xf_float_vec)-1] + 0.5 ) and solutions[ii] > ( xf_float_vec[0] - 0.5 ) :
            predicted_xf_binned[i_bins] = np.real(solutions[ii])
            break
    k = 0
    for point in point_list:
        ypoints[k] = w0s_arr[i_bins,point]
        wpoints[k] = w0s_weight[point]
        k = k + 1
    coeffs = np.polyfit(xpoints,ypoints,1,w=wpoints)
#    coeffs = np.polyfit(x0_float_vec,w0s_arr[i_bins,:],3,w=w0s_weight)

    predicted_w0s_binned[i_bins] = np.polyval(coeffs,predicted_xf_binned[i_bins])


predicted_xf = jackknife_for_binned(predicted_xf_binned)
predicted_w0s = jackknife_for_binned(predicted_w0s_binned)



print( flow_type,obs_type,'x_f = ',predicted_xf[0],' +- ',predicted_xf[1],'  w_0s = ',predicted_w0s[0],' +- ',predicted_w0s[1] )




