reset
set term pos eps enhanced color solid "Helvetica" 25 size 6in,6in
set output "a016fm_hisq_masses_plot.eps"

plot [0:14][]"a016fm_hisq_masses.dat" u (($1+1)*0.2):2:3 w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u (($1+1)*0.2+2):(1.1*$4):(1.1*$5) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u (($1+1)*0.2+4):(1.2*$6):(1.2*$7) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u (($1+1)*0.2+6):(1.5*$8):(1.5*$9) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u (($1+1)*0.2+8):(2.0*$10):(2.0*$11) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u (($1+1)*0.2+10):(4.0*$12):(4.0*$13) w err lw 3 notitle,\
"a016fm_hisq_masses.dat" u (($1+1)*0.2+12):(8.0*$14):(8.0*$15) w err lw 3 notitle

