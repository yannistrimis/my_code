import numpy as np


filename = input()
str_nt = input()
str_n_bins = input()

n_bins = int(str_n_bins)
nt = int(str_nt)

f_write = open('%s.coshmeffdata'%(filename),'w')

def main() :

    meff = np.zeros( (int(nt/2)-3,n_bins) )

    for i_bin in range(n_bins):
        print('i_bin=',i_bin)
        f_read = open('%s/%s.specdata.jackbin_%d'%(filename),'r')
        content = f_read.readlines()
        f_read.close()

        y_av = np.zeros(int(nt/2)+1)

        for i in range(int(nt/2)+1):
            line = content[i].strip()
            y_av[i] = float(line)

        for t in range(int(nt/2)-3):
            c2p = y_av[t+4]
            c2m = y_av[t]
            c0 = y_av[t+2]
            print('t=',t)
            meff[t,i_bin] = 0.5*np.arccosh( (c2p+c2m)/(2*c0) )

    meff_averr = np.zeros( (int(nt/2)-3,2) )
    for t in range(int(nt/2)-3):

        for i_bin in range(n_bins) :
            meff_averr[t,0] = meff_averr[t,0] + meff[t,i_bin]
        meff_averr[t,0] = meff_averr[t,0] / n_bins

        for i_bin in range(n_bins) :
            meff_averr[t,1] = meff_averr[t,1] + (meff[t,i_bin]-meff_averr[t,0])**2
        meff_averr[t,1] = meff_averr[t,1]*(n_bins-1)/n_bins
        meff_averr[t,1] = np.sqrt(meff_averr[t,1])

        f_write.write('%d %f %f\n'%(t, meff_averr[t,0],meff_averr[t,1]))
    f_write.close()


if __name__ == '__main__' :
    main()
