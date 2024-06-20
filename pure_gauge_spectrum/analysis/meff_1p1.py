import numpy as np

nx=16
nt=64
vol = str(nx)+str(nt)
beta = '704115'
x0 = '181411'
stream = 'a'

# cur_dir = '/mnt/home/trimisio/plot_data/spec_data/l'+vol+'b'+beta+'x'+x0+stream # ICER
cur_dir = '/home/yannis/Physics/LQCD/spec_data/l'+vol+'b'+beta+'x'+x0+stream # LAPTOP

pre_name = input()
str_n_bins = input()
n_bins = int(str_n_bins)

f_write = open('%s/%s.coshmeffdata'%(cur_dir,pre_name),'w')

def main() :

    meff_plus = np.zeros( (int(nt/2)-1,n_bins) )
    meff_minus = np.zeros( (int(nt/2)-1,n_bins) )

    for i_bin in range(n_bins):
        print('i_bin=',i_bin)   
        f_read = open('%s/%s.specdata.jackbin_%d'%(cur_dir,pre_name,i_bin),'r')
        content = f_read.readlines()
        f_read.close()

        y_av = np.zeros(int(nt/2)+1)

        for t in range(int(nt/2)+1):
            line = content[t].strip()
            y_av[t] = float(line)

        for t in range(int(nt/2)-2):

            A = y_av[t+1]**2 - y_av[t+2]*y_av[t]
            B = y_av[t+3]*y_av[t] - y_av[t+2]*y_av[t+1]
            C = y_av[t+2]**2 - y_av[t+3]*y_av[t+1]

            if A * C < 0 :

                x_plus = B/(2*A) + np.sqrt(B**2-4*A*C)/ (2*np.abs(A))
                x_minus = -B/(2*A) + np.sqrt(B**2-4*A*C)/ (2*np.abs(A))

                meff_plus[t,i_bin] = -np.log( x_plus )
                meff_minus[t,i_bin] = -np.log( x_minus )
            else :
                meff_plus[t,i_bin] = -1
                meff_minus[t,i_bin] = -1



    meff_plus_averr = np.zeros( (int(nt/2)-2,2) )
    meff_minus_averr = np.zeros( (int(nt/2)-2,2) )

    for t in range(int(nt/2)-2):

        for i_bin in range(n_bins) :
            meff_plus_averr[t,0] = meff_plus_averr[t,0] + meff_plus[t,i_bin]
            meff_minus_averr[t,0] = meff_minus_averr[t,0] + meff_minus[t,i_bin]

        meff_plus_averr[t,0] = meff_plus_averr[t,0] / n_bins
        meff_minus_averr[t,0] = meff_minus_averr[t,0] / n_bins


        for i_bin in range(n_bins) :
            meff_plus_averr[t,1] = meff_plus_averr[t,1] + (meff_plus[t,i_bin]-meff_plus_averr[t,0])**2
            meff_minus_averr[t,1] = meff_minus_averr[t,1] + (meff_minus[t,i_bin]-meff_minus_averr[t,0])**2


        meff_plus_averr[t,1] = meff_plus_averr[t,1]*(n_bins-1)/n_bins
        meff_plus_averr[t,1] = np.sqrt(meff_plus_averr[t,1])

        meff_minus_averr[t,1] = meff_minus_averr[t,1]*(n_bins-1)/n_bins
        meff_minus_averr[t,1] = np.sqrt(meff_minus_averr[t,1])



        f_write.write('%d %f %f %f %f\n'%(t, meff_plus_averr[t,0],meff_plus_averr[t,1], meff_minus_averr[t,0],meff_minus_averr[t,1]))

    f_write.close()


if __name__ == '__main__' :
    main()
