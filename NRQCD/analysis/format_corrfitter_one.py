# 4 SPACES INSTEAD OF TAB
import numpy as np

name = input()
str_first_file = input()
str_last_file = input()

first_file = int(str_first_file)
last_file = int(str_last_file)

f_write = open('%s.specdata'%(name),'w')

for i_file in range(first_file,last_file+1):
    f_read = open('%s.%d'%(name,i_file),'r')
    content = f_read.readlines()
    f_write.write( 'PROP' )
    for i_line in range(1,len(content)) :
        split1 = content[i_line].split('     ')
        split2 = split1.split('  ')
        f_write.write( ' %s'%(split2[1]) )
    f_write.write('\n')
    f_read.close()

f_write.close()

print("first file: %d\nlast file: %d"%(first_file,last_file) )
