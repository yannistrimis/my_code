#!/usr/bin/env gnuplot

set terminal postscript eps enhanced color lw 2
set output "pion_split_w0_ahisq.eps"

set key outside

set xlabel "log({/Symbol x})"
set ylabel "{/Symbol D}m^2"

set logscale x

#us_iso = 0.873262
#ut_iso = 0.873264

us_iso = 1
ut_iso = 1

plot [0.9:8.5][]\
    "pion_split_w0_ahisq_usut.dat" u 1:($2/$17 * ut_iso):($3/$17 * ut_iso)   w yerrorbars lw 2 title "05", \
    "pion_split_w0_ahisq_usut.dat" u 1:($4/$16 * us_iso):($5/$16 * us_iso)   w yerrorbars lw 2 title "i5", \
    "pion_split_w0_ahisq_usut.dat" u 1:($6/$16/$17 * us_iso*ut_iso ):($7/$16/$17 * us_iso*ut_iso )   w yerrorbars lw 2 title "ij", \
    "pion_split_w0_ahisq_usut.dat" u 1:8:9   w yerrorbars lw 2 title "i0", \
    "pion_split_w0_ahisq_usut.dat" u 1:10:11 w yerrorbars lw 2 title "i", \
    "pion_split_w0_ahisq_usut.dat" u 1:12:13 w yerrorbars lw 2 title "0", \
    "pion_split_w0_ahisq_usut.dat" u 1:14:15 w yerrorbars lw 2 title "s"

set output
