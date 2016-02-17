import numpy as np
from matplotlib import pyplot as plt
from sklearn.svm import SVR

X = np.arange(0,100)
Y = np.sin(X)

svr_rbf = SVR(kernel='rbf', C=1e5, gamma=1e5)
y_rbf = svr_rbf.fit(X[:-10, np.newaxis], Y[:-10]).predict(X[:, np.newaxis])

figure = plt.figure()
tick_plot = figure.add_subplot(1, 1, 1)
tick_plot.plot(X, Y, label='data', color='green', linestyle='-')
tick_plot.axvline(x=X[-10], alpha=0.2, color='gray')
tick_plot.plot(X, y_rbf, label='data', color='blue', linestyle='--')
plt.show()