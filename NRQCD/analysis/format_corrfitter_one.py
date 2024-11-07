import numpy as np
import re

name = input()
str_first_file = input()
str_last_file = input()

first_file = int(str_first_file)
last_file = int(str_last_file)

f_write_1s0 = open('%s_1S0.specdata'%(name),'w')
f_write_3s1x = open('%s_3S1x.specdata'%(name),'w')
f_write_3s1y = open('%s_3S1y.specdata'%(name),'w')
f_write_3s1z = open('%s_3S1z.specdata'%(name),'w')
f_write_3s1 = open('%s_3S1.specdata'%(name),'w')
f_write_1s03s1x = open('%s_1S03S1x.specdata'%(name),'w')
f_write_1s03s1 = open('%s_1S03S1.specdata'%(name),'w')

for i_file in range(first_file,last_file+1):
    f_read = open('%s.%d.twostate'%(name,i_file),'r')
    content = f_read.readlines()
    f_read.close()
    f_write_1s0.write( 'PROP' )
    f_write_3s1x.write( 'PROP' )
    f_write_3s1y.write( 'PROP' )
    f_write_3s1z.write( 'PROP' )
    f_write_3s1.write( 'PROP' )
    f_write_1s03s1x.write( 'PROP' )
    f_write_1s03s1.write( 'PROP' )

    for i_line in range(2,len(content)-1) :
        line = content[i_line].lstrip()
        line = line.rstrip()
        splitline = re.split(r" {1,2}", line) 

        aver = ( float(splitline[3]) + float(splitline[5]) + float(splitline[7]) ) / 3.0
        ratiox = float(splitline[1]) / float(splitline[3])
        ratio = float(splitline[1]) / aver
        f_write_1s0.write( ' %s'%(splitline[1]) )
        f_write_3s1x.write( ' %s'%(splitline[3]) )
        f_write_3s1y.write( ' %s'%(splitline[5]) )
        f_write_3s1z.write( ' %s'%(splitline[7]) )
        f_write_3s1.write( ' %.10E'%(aver) )
        f_write_1s03s1x.write( ' %.10E'%(ratiox) )
        f_write_1s03s1.write( ' %.10E'%(ratio) )

    f_write_1s0.write("\n")
    f_write_3s1x.write("\n")
    f_write_3s1y.write("\n")
    f_write_3s1z.write("\n")
    f_write_3s1.write("\n")
    f_write_1s03s1x.write("\n")
    f_write_1s03s1.write("\n")


f_write_1s0.close()
f_write_3s1x.close()
f_write_3s1y.close()
f_write_3s1z.close()
f_write_3s1.close()
f_write_1s03s1x.close()
f_write_1s03s1.close()


print("first file: %d\nlast file: %d"%(first_file,last_file) )
