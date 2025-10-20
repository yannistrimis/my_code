import numpy as np
import matplotlib.pyplot as plt
import sys
sys.path.insert(0, '..')

from python_funcs import *


def mycos(x) :
  return np.cos(x)

def mysin(x) :
  return np.sin(x)

N = 100
xlim = 5
dt = 2.0*xlim / N

x_values = np.linspace(-xlim, xlim, N+1 )
y_values = mycos(x_values)

y_values_2 = deriv( mysin(x_values), dt )


plt.plot(x_values,y_values,'r')
plt.plot(x_values,y_values_2,'g')
plt.show()
