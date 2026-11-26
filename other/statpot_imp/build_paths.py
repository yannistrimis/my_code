#

import numpy as np
import sys
sys.path.insert(0, '.')
from utils import *

initial_path = input()

path_collection = []
path_collection.append([initial_path])
new_path = extend_path( initial_path, 1, 0, 3 )
path_collection.append([new_path])
new_path = extend_path( initial_path, 2, 0, 3 )
path_collection[1].append(new_path)
print( path_collection )
