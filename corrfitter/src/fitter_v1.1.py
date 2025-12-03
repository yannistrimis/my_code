
from __future__ import print_function   # makes this work for python2 and 3

# RUN conda deactivate IF ON CMSE WORKSTATION

# tdata CORRESPONDS TO THE DATA IN THE CORRELATOR FILE, WHETHER THIS HAS BEEN THINNED OR NOT.
# THE COVARIANCE MATRIX IS CALCULATED TAKING THE WHOLE DATASET INTO CONSIDERATION-- THIS IS WHY
# THINNING HAS TO BE DONE IN ADVANCE, BY THE WAY.
# tfit IS THE POINTS USED FOR THE FIT. IF tfit IS NOT SPECIFIED THEN ALL POINTS IN tdata ARE
# GOING TO BE USED FOR THE FIT.

import collections
import gvar as gv
import numpy as np
import corrfitter as cf
from scipy.special import gammainc
import sys
sys.path.insert(0, '../..')
from python_funcs import *

def make_prior(N,M):
    prior = collections.OrderedDict()

#    prior['log(an)'] = gv.log(gv.gvar(['0.23(10000.0)', '0.1(10000.0)']))
#    prior['log(dEn)'] = gv.log(gv.gvar(['0.03(10000.0)', '0.10(10000.0)']))
    prior['log(an)'] = gv.log(gv.gvar(N*['0.03(10000.0)']))
    prior['log(dEn)'] = gv.log(gv.gvar(N*['0.15(10000.0)']))

#    prior['log(ao)'] = gv.log(gv.gvar(['0.06(10000.0)', '0.1(10000.0)']))
#    prior['log(dEo)'] = gv.log(gv.gvar(['0.09(10000.0)', '0.2(10000.0)']))
    prior['log(ao)'] = gv.log(gv.gvar(M*['0.06(10000.0)']))
    prior['log(dEo)'] = gv.log(gv.gvar(M*['0.099(10000.0)']))

    return prior

def main():

    file_name = input()
    str_tmin = input()
    str_tmax = input()
    str_tdatamin = input()
    str_tdatamax = input()
    str_tstep = input() # tstep for tfit and tdata is the same
    str_tp = input()
    str_N = input()
    str_M = input()
    str_sn = input()
    str_so = input()
    str_bin = input()
    correlated = input()
    priors = input()
    fittype = input()
    opp = input()

    tmin = int(str_tmin)
    tmax = int(str_tmax)
    tdatamin = int(str_tdatamin)
    tdatamax = int(str_tdatamax)
    tstep = int(str_tstep)
    my_tp = int(str_tp)

    data = make_data(file_name,str_bin)

    my_tfit = range(tmin,tmax+1,tstep)
    my_tdata = range(tdatamin,tdatamax+1,tstep)


    my_models = make_models(my_tdata,my_tfit,my_tp,str_sn,str_so,opp)
    fitter = cf.CorrFitter(models=my_models)

    p0 = None

    N = int(str_N)
    M = int(str_M)

    if fittype == 'onefit' :
        print('\ndata from: ',file_name,'\n')
        print('tmin = ',tmin,'   tmax = ',tmax,'\n')

    prior = make_prior(N,M)
    if correlated == "corr" :
        fit = fitter.lsqfit( data=data, prior=prior, p0=p0, method='lm') #,  svdcut=0.005)
    elif correlated == "uncorr" :
        fit = fitter.lsqfit( udata=data, prior=prior, p0=p0, method='lm' )
    if fittype == 'onefit' :
        print(30 * '=', 'nterm =', N,M)
        print(fit)
    p0 = fit.pmean

    dof_real = len(my_tfit)-2*N-2*M
    chi2_real = fit.chi2

    for i_state in range(N) :
        chi2_real = chi2_real - ( gv.exp(prior['log(an)'])[i_state].mean - fit.p['an'][i_state].mean )**2 / ( gv.exp(prior['log(an)'])[i_state].sdev )**2
        chi2_real = chi2_real - ( gv.exp(prior['log(dEn)'])[i_state].mean - fit.p['dEn'][i_state].mean )**2 / ( gv.exp(prior['log(dEn)'])[i_state].sdev )**2

    for i_state in range(M) :
        chi2_real = chi2_real - ( gv.exp(prior['log(ao)'])[i_state].mean - fit.p['ao'][i_state].mean )**2 / ( gv.exp(prior['log(ao)'])[i_state].sdev )**2
        chi2_real = chi2_real - ( gv.exp(prior['log(dEo)'])[i_state].mean - fit.p['dEo'][i_state].mean )**2 / ( gv.exp(prior['log(dEo)'])[i_state].sdev )**2

    Q_man = 1-gammainc(0.5*fit.dof,0.5*fit.chi2)
    Q_real = 1-gammainc(0.5*dof_real,0.5*chi2_real)
    if fittype == 'onefit' :
        print('\n')
        if correlated == "corr" :
            print("CORRELATED FIT:\n")
        elif correlated == "uncorr" :
            print("UNCORRELATED FIT:\n")
        print_results(fit,N,M)
        print('[','GOODNESS OF FIT FROM corrfitter CHI_2:',']','\n',)
        print( 'augmented chi2/dof [dof]: %.3f [%d]\tQ = %.3f\ndeaugmented chi2/dof [dof]:  %.3f [%d]\tQ = %.3f\n'%(fit.chi2/fit.dof,fit.dof,Q_man,chi2_real/dof_real,dof_real,Q_real) )
        print('\n')
        print('#DATA dDATA FIT dFIT REDUCED_DIST')
        it = -1
        for t in my_tfit :
            it = it + 1
            it_shift = it + int((tmin-tdatamin)/tstep)
            print(t, data['PROP'][it_shift].mean, data['PROP'][it_shift].sdev, my_models[0].fitfcn(p=fit.p,t=my_tfit)[it].mean, my_models[0].fitfcn(p=fit.p,t=my_tfit)[it].sdev,(data['PROP'][it_shift].mean-my_models[0].fitfcn(p=fit.p,t=my_tfit)[it].mean)/data['PROP'][it_shift].sdev)

    cov_matrix = np.zeros((len(my_tfit),len(my_tfit)))
    meas_arr = np.zeros(len(my_tfit))
    fit_arr = np.zeros(len(my_tfit))

    it = -1
    for t in my_tfit :
        it = it + 1
        it_shift = it + int((tmin-tdatamin)/tstep)
        jt = -1
        for u in my_tfit :
            jt = jt + 1
            jt_shift = jt + int((tmin-tdatamin)/tstep)
            cov_matrix[it,jt] = gv.evalcov(data)['PROP','PROP'][it_shift,jt_shift]
        meas_arr[it] = data['PROP'][it_shift].mean
        fit_arr[it] = my_models[0].fitfcn(p=fit.p,t=my_tfit)[it].mean
    if correlated == "corr" :
        chi2bydof_from_points = chisq_by_dof(meas_arr,fit_arr,cov_matrix,dof_real)
    elif correlated == "uncorr" :
        chi2bydof_from_points = 0.0
        it = -1
        for t in my_tfit :
            it = it + 1
            it_shift = it + int((tmin-tdatamin)/tstep)
            chi2bydof_from_points = chi2bydof_from_points + ( data['PROP'][it_shift].mean - my_models[0].fitfcn(p=fit.p,t=my_tfit)[it].mean )**2 / ( data['PROP'][it_shift].sdev**2 )
        chi2bydof_from_points = chi2bydof_from_points / dof_real

    Q_from_points = q_value(chi2bydof_from_points,dof_real)
    if fittype == 'onefit' :
        print('\n')
        print('[','GOODNESS OF FIT FROM MANUALLY CALCD CHI_2 (ONLY FOR INFINITELY WIDE PRIORS AND NO SVD CUTS):',']','\n')
        print( 'chi2/dof from fit points [dof]: %.3f [%d]\tQ = %.3f\n'%(chi2bydof_from_points,dof_real,Q_from_points) )

# THE FOLLOWING IS FOR CHECK OF COVARIANCE MATRIX EIGENVALUES
#        data_array =  gv.dataset.Dataset(file_name)
#        svd = gv.dataset.svd_diagnosis(data_array["PROP"])
#        svd.plot_ratio(show=True)

    elif fittype == 'scanfit' :
        if priors == 'no_priors' :
            print("%d %d %.8f %d %.8f"%(tmin,tmax,chi2_real/dof_real,dof_real,Q_real), end="")
        if priors == 'yes_priors' :
            print("%d %d %.8f %d %.8f"%(tmin,tmax,fit.chi2/fit.dof,fit.dof,Q_man), end="")
        print_results_scan(fit,N,M)
        print("")




def make_data(filename,str_bin):
    return gv.dataset.avg_data(cf.read_dataset(filename,binsize=int(str_bin)))

def make_models(my_tdata,my_tfit,my_tp,str_sn,str_so,opp):
    return [cf.Corr2( datatag='PROP', tp=my_tp, tdata=my_tdata, tfit=my_tfit, a=('an','ao'), b=('an','ao'), dE=('dEn','dEo'), s=(float(str_sn),float(str_so)), opp=opp )]


def print_results(fit,N,M):
    p = fit.p

    if N>0:
        En = np.cumsum(p['dEn'])
        an = p['an']

    if M>0:
        Eo = np.cumsum(p['dEo'])
        ao = p['ao']

    for i_state in range(N) :
        print('an[%d] = %s\t En[%d] = %s\n'%(i_state,an[i_state],i_state,En[i_state]))
    for j_state in range(M) :
        print('ao[%d] = %s\t Eo[%d] = %s\n'%(j_state,ao[j_state],j_state,Eo[j_state]))


def print_results_scan(fit,N,M):
    p = fit.p

    if N>0:
        En = np.cumsum(p['dEn'])
        an = p['an']

    if M>0:
        Eo = np.cumsum(p['dEo'])
        ao = p['ao']

    for i_state in range(N) :
        print(" an[%d]: %.4f %.4f En[%d]: %.6f %.6f"%(i_state,an[i_state].mean,an[i_state].sdev,i_state,En[i_state].mean,En[i_state].sdev), end="")
    for j_state in range(M) :
        print(" ao[%d]: %.4f %.4f Eo[%d]: %.6f %.6f"%(j_state,ao[j_state].mean,ao[j_state].sdev,j_state,Eo[j_state].mean,Eo[j_state].sdev), end="")



def test_param(fit,N,M,to_print_state,to_print_nr):

    flag = 'ok'
    p = fit.p

    ref_E_mean = p['dE'+to_print_state][int(to_print_nr)].mean
    ref_a_mean = p['a'+to_print_state][int(to_print_nr)].mean

    if N>0:
        En = np.cumsum(p['dEn'])
        an = p['an']

    if M>0:
        Eo = np.cumsum(p['dEo'])
        ao = p['ao']

#    for i_state in range(N) :
#        if ( np.abs(En[i_state].mean) < 0.05*np.abs(ref_E_mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(En[i_state].mean) > 100*np.abs(ref_E_mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(an[i_state].mean) < 0.005*np.abs(ref_a_mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(En[i_state].sdev) > 100*np.abs(En[i_state].mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(an[i_state].sdev) > 100*np.abs(an[i_state].mean) ) :
#            flag = 'not_ok'

#    for j_state in range(M) :
#        if ( np.abs(Eo[j_state].mean) < 0.05*np.abs(ref_E_mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(Eo[j_state].mean) > 100*np.abs(ref_E_mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(ao[j_state].mean) < 0.005*np.abs(ref_a_mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(Eo[j_state].sdev) > 100*np.abs(Eo[j_state].mean) ) :
#            flag = 'not_ok'
#        if ( np.abs(ao[j_state].sdev) > 100*np.abs(ao[j_state].mean) ) :
#            flag = 'not_ok'


    return flag


if __name__ == '__main__':
    main()

