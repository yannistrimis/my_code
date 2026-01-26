reset
set term pos eps enhanced color solid "Helvetica" 22 size 5in,4in
set output "a016fm_hisq_splittings_plot.eps"

#goldstone pion masses:

g10=0.254828 
g11=0.232011 
g12=0.212952 
g15=0.169906 
g20=0.127608 
g40=0.063787 
g80=0.032516

gs40=0.138895
gs80=0.069633

set xlabel "{/Symbol x}"
set ylabel "{m_{/Symbol p}^2-m_G^2}"

set xrange[0:14]
set xtics("{/Symbol x}=1" 1, "{/Symbol x}=1.1" 3, "{/Symbol x}=1.2" 5,"{/Symbol x}=1.5" 7,"{/Symbol x}=2" 9,"{/Symbol x}=4" 11, "{/Symbol x}=8" 13)

plot [0:16][]"a016fm_hisq_masses.dat" u ($1*0.2+1):(($2**2-g10**2)):($2*$3*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+3):(1.1**2*($4**2-g11**2)):(1.1**2*$4*$5*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+5):(1.2**2*($6**2-g12**2)):(1.2**2*$6*$7*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+7):(1.5**2*($8**2-g15**2)):(1.5**2*$8*$9*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+9):(2.0**2*($10**2-g20**2)):(2.0**2*$10*$11*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+11):(4.0**2*($12**2-g40**2)):(4.0**2*$12*$13*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+11):(4.0**2*($16**2-gs40**2)):(4.0**2*$16*$17*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+13):(8.0**2*($14**2-g80**2)):(8.0**2*$14*$15*2) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u ($1*0.2+13):(8.0**2*($18**2-gs80**2)):(8.0**2*$18*$19*2) w err lw 3 notitle

