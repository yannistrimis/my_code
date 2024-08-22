import numpy as np

f1name = input()
f2name = input()
flowtime = input()

f_write = open( "%s"%(f2name), "w" )
f_write.write("#iconf charge icharge\n")

for i_file in range(101,301):
  f_read = open("%s.%d"%(f1name,i_file), "r" )
  content = f_read.readlines()
  f_read.close()

  for line in content:
    stripline = line.strip()
    splitline = stripline.split(" ")
    if splitline[0] == "GFLOW:" and splitline[1] == flowtime :
      f_write.write("%d %s NA\n"%(i_file,splitline[8])) #,splitline[11]))
      break

f_write.close()
