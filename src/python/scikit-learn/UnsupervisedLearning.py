#2.2.4.1.1. K-means clustering
import numpy as np
from sklearn import cluster,datasets
iris = datasets.load_iris()
X_iris = iris.data
y_iris = iris.target

k_means = cluster.KMeans(n_clusters=3)
print k_means.fit(X_iris)
print k_means.labels_[::10]
print y_iris[::10]

#Application example: vector quantization
import scipy as sp
try:
    lena = sp.lena()
except AttributeError:
    from scipy import misc
    lena = misc.lena()
X = lena.reshape((-1,1))
k_means = cluster.KMeans(n_clusters=5,n_init=1)
print k_means.fit(X)
values = k_means.cluster_centers_.squeeze()
labels = k_means.labels_
lena_compressed = np.choose(labels,values)
lena_compressed.shape = lena.shape
#2.2.4.1.2. Hierarchical agglomerative clustering: Ward
#2.2.4.2.1. Principal component analysis: PCA
#Create a signal with only 2 useful dimensions\
x1 = np.random.normal(size=100)
x2 = np.random.normal(size=100)
x3 = x1 + x2
X = np.c_[x1,x2,x3]
#
from sklearn import decomposition
pca = decomposition.PCA()
print pca.fit(X)
print pca.explained_variance_
#
pca.n_components = 2
X_reduced = pca.fit_transform(X)
print X_reduced.shape
#ICA
# Generate sample data
time = np.linspace(0, 10, 2000)
s1 = np.sin(2 * time)  # Signal 1 : sinusoidal signal
s2 = np.sign(np.sin(3 * time))  # Signal 2 : square signal
S = np.c_[s1, s2]
S += 0.2 * np.random.normal(size=S.shape)  # Add noise
S /= S.std(axis=0)  # Standardize data
# Mix data
A = np.array([[1, 1], [0.5, 2]])  # Mixing matrix
X = np.dot(S, A.T)  # Generate observations

# Compute ICA
ica = decomposition.FastICA()
S_ = ica.fit(X).transform(X)  # Get the estimated sources
A_ = ica.get_mixing_matrix()  # Get estimated mixing matrix
print np.allclose(X, np.dot(S_, A_.T))