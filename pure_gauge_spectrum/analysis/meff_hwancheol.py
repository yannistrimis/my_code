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
        f_read = open('%s.jackbinval_%d'%(filename,i_bin),'r')
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
            quant = (c2p+c2m)/(2*c0)
            if ( quant >= 1.0 ):
                meff[t,i_bin] = 0.5*np.arccosh( quant )
            else :
                meff[t,i_bin] = -100

    meff_averr = np.zeros( (int(nt/2)-3,2) )
    for t in range(int(nt/2)-3):
        flag = 0
        for i_bin in range(n_bins) :
            if ( meff[t,i_bin] == -100 ):
                flag = 1
            meff_averr[t,0] = meff_averr[t,0] + meff[t,i_bin]
        meff_averr[t,0] = meff_averr[t,0] / n_bins

        if flag == 1 :
            meff_averr[t,0] = -100
            continue

        for i_bin in range(n_bins) :
            meff_averr[t,1] = meff_averr[t,1] + (meff[t,i_bin]-meff_averr[t,0])**2
        meff_averr[t,1] = meff_averr[t,1]*(n_bins-1)/n_bins
        meff_averr[t,1] = np.sqrt(meff_averr[t,1])
        f_write.write('%d %f %f\n'%(t, meff_averr[t,0],meff_averr[t,1]))
    f_write.close()


if __name__ == '__main__' :
    main()
