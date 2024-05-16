reset
set terminal postscript dashed color \
 font 'Helvetica,18' linewidth 3
set output "w0_and_xi_vs_beta.ps"

#set multiplot layout 3,1 title "w_0 and {/Symbol x}_0 vs {/Symbol b} for {/Symbol x}=4"
#unset key

#set ylabel "{/Symbol x}_0"
#unset xlabel
#plot [6.85:7.35][]"beta_swc_xiR_4.data" u 1:2:3 w err
#set ylabel "w_0"
#set xlabel "{/Symbol b}"
#plot [6.85:7.35][]"beta_swc_xiR_4.data" u 1:4:5 w err

plot "beta_swc_xiR_4.data" u 4:($2/4/$4):($3/4/$4) w err, "beta_swc_xiR_2.data" u 4:($2/2/$4):($3/2/$4) w err
