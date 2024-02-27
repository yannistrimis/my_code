reset
set terminal postscript dashed color \
 font 'Helvetica,18' linewidth 3
set output "schemes.ps"

set key top right
set key font ",12"

plot [6.875:7.325][] "beta_swc.data" u 1:2:3 w err pt 1 lc rgb "red" title "SWC",\
"beta_sww.data" u 1:2:3 w err pt 1 lc rgb "green" title "SWW",\
"beta_sws.data" u 1:2:3 w err pt 1 lc rgb "blue" title "SWS",\
"beta_ssc.data" u 1:2:3 w err pt 1 lc rgb "cyan" title "SSC",\
"beta_ssw.data" u 1:2:3 w err pt 1 lc rgb "violet" title "SSW",\
"beta_sss.data" u 1:2:3 w err pt 1 lc rgb "yellow" title "SSS",\
"beta_szc.data" u 1:2:3 w err pt 1 lc rgb "dark-red" title "SZC",\
"beta_szi.data" u 1:2:3 w err pt 1 lc rgb "dark-green" title "SZI",\
"beta_szw.data" u 1:2:3 w err pt 1 lc rgb "dark-blue" title "SZW",\
"beta_szs.data" u 1:2:3 w err pt 1 lc rgb "orange" title "SZS",\
"beta_swc.data" u 1:2:3 w l lw 1 lc rgb "red" notitle,\
"beta_sww.data" u 1:2:3 w l lw 1 lc rgb "green" notitle,\
"beta_sws.data" u 1:2:3 w l lw 1 lc rgb "blue" notitle,\
"beta_ssc.data" u 1:2:3 w l lw 1 lc rgb "cyan" notitle,\
"beta_ssw.data" u 1:2:3 w l lw 1 lc rgb "violet" notitle,\
"beta_sss.data" u 1:2:3 w l lw 1 lc rgb "yellow" notitle,\
"beta_szc.data" u 1:2:3 w l lw 1 lc rgb "dark-red" notitle,\
"beta_szi.data" u 1:2:3 w l lw 1 lc rgb "dark-green" notitle,\
"beta_szw.data" u 1:2:3 w l lw 1 lc rgb "dark-blue" notitle,\
"beta_szs.data" u 1:2:3 w l lw 1 lc rgb "orange" notitle

