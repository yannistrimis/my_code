import numpy as np

filename = input()
f_read = open(filename, "r")

content = f_read.readlines()
f_read.close()

for i_line in range(len(content)) :
    rand_i = np.random.randint(0,len(content))
    print( content[rand_i].strip() )
#    print(rand_i,i_line)

