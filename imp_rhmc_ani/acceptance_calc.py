import numpy as np

filename = input()

f_read = open("%s"%(filename), "r")
content = f_read.readlines()
f_read.close()

traj = len(content)

traj_pos = 0
traj_neg = 0

prob = 0

for line in content :
  strip_line = line.strip()
  split_line = strip_line.split(" ")
  if float(split_line[1]) < 0 :
    traj_neg = traj_neg + 1
  elif float(split_line[1]) > 0 :
    traj_pos = traj_pos + 1
    prob = prob + np.exp(-float(split_line[1]))

prob = prob/traj_pos

print("acceptance = N_neg/N_tot + << exp(-dS), dS>0 >> * N_pos/N_tot")
print("= %d/%d + %f*%d/%d"%(traj_neg,traj,prob,traj_pos,traj))

acc = traj_neg/traj + prob*traj_pos/traj
print("= %f"%acc)
