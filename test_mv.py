import numpy as np
import pandas as pd
from scipy.io import mmread
from sksparse.cholmod import cholesky
from scilmm.SparseCholesky import HE


A = mmread('A.mm').tocsr()
y = pd.read_csv('y.txt', delimiter=' ', header=None)
covariate_matrix = np.ones(1000).reshape(-1, 1)

HE(cholesky, [A], covariate_matrix, y[1], MQS=True, verbose=False, sim_num=100, compute_stderr=False) # ~0.53
HE(cholesky, [A], covariate_matrix, y[2], MQS=True, verbose=False, sim_num=100, compute_stderr=False) # 0.29
HE(cholesky, [A], covariate_matrix, y[1], MQS=True, verbose=False, sim_num=100, compute_stderr=False, y2=y[2]) # ~0.24
