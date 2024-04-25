reset
set terminal postscript dashed color \
 font 'Helvetica,18' linewidth 3
set output "schemes_xiR_4.ps"

set key top right
set key font ",12"

plot [6.875:7.325][] "beta_swc_xiR_4.data" u 1:2:3 w err pt 1 lc rgb "red" title "SWC",\
"beta_sww_xiR_4.data" u 1:2:3 w err pt 1 lc rgb "green" title "SWW",\
"beta_sws_xiR_4.data" u 1:2:3 w err pt 1 lc rgb "blue" title "SWS",\
"beta_ssc_xiR_4.data" u 1:2:3 w err pt 1 lc rgb "cyan" title "SSC",\
"beta_ssw_xiR_4.data" u 1:2:3 w err pt 1 lc rgb "violet" title "SSW",\
"beta_sss_xiR_4.data" u 1:2:3 w err pt 1 lc rgb "yellow" title "SSS",\
"beta_szi_xiR_4.data" u 1:2:3 w err pt 1 lc rgb "dark-green" title "SZI",\
"beta_swc_xiR_4.data" u 1:2:3 w l lw 1 lc rgb "red" notitle,\
"beta_sww_xiR_4.data" u 1:2:3 w l lw 1 lc rgb "green" notitle,\
"beta_sws_xiR_4.data" u 1:2:3 w l lw 1 lc rgb "blue" notitle,\
"beta_ssc_xiR_4.data" u 1:2:3 w l lw 1 lc rgb "cyan" notitle,\
"beta_ssw_xiR_4.data" u 1:2:3 w l lw 1 lc rgb "violet" notitle,\
"beta_sss_xiR_4.data" u 1:2:3 w l lw 1 lc rgb "yellow" notitle,\
"beta_szi_xiR_4.data" u 1:2:3 w l lw 1 lc rgb "dark-green" notitle
