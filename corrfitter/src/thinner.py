import numpy as np

filename = input()

tmin=0
tmax=64
tstep=3

confmin=0
confmax=1599
confstep=1

t_range = range(tmin+1,tmax+2,tstep) # +1 BECAUSE 0th ELEMENT IS "PROP"
conf_range = range(confmin,confmax+1,confstep)

temp_filename = filename + ".thin" + str(tstep)

f_read = open(filename, "r")
f_write = open(temp_filename, "w")

content = f_read.readlines()
f_read.close()

for iconf in conf_range :
  line = content[iconf].split(" ")
  f_write.write("PROP")
  for it in t_range :
    f_write.write(" %s"%(line[it].strip()))
  f_write.write("\n")
f_write.close()
