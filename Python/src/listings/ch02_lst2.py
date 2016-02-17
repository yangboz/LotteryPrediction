
from numpy import *

# z: position, w: bandwidth, xv: vector of points
def kde( z, w, xv ):
    return sum( exp(-0.5*((z-xv)/w)**2)/sqrt(2*pi*w**2) )

d = loadtxt( "../datasets/ch02_presidents.txt", usecols=(2,) )

w = 2.5
alist = []
for x in linspace( min(d)-w, max(d)+w, 1000 ):
    print x, kde( x, w, d );alist.append(kde( x, w, d ))
print alist

import matplotlib.pyplot as plt
data = [1.5]*7 + [2.5]*2 + [3.5]*8 + [4.5]*3 + [5.5]*1 + [6.5]*8
plt.hist(data, bins=6)
plt.show()

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
data = [1.5]*7 + [2.5]*2 + [3.5]*8 + [4.5]*3 + [5.5]*1 + [6.5]*8
density = gaussian_kde(data)
xs = np.linspace(0,8,200)
density.covariance_factor = lambda : .25
density._compute_covariance()
plt.plot(xs,density(xs))
plt.show()