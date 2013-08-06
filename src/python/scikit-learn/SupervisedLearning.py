import numpy as np
from sklearn import datasets

iris = datasets.load_iris()
iris_X = iris.data
iris_y = iris.target
print np.unique(iris_y)
#Split the data in train and test data
#A random permutation, to split the data randomly
np.random.seed(0)
indics = np.random.permutation(len(iris_X))
iris_X_train = iris_X[indics[:-10]]
iris_y_train = iris_y[indics[:-10]]
iris_X_test = iris_X[indics[-10:]]
iris_y_test = iris_y[indics[-10:]]
#Create and fit a nearest-neighbor classifer
from sklearn.neighbors import KNeighborsClassifier
knn = KNeighborsClassifier()
#Trainning
print knn.fit(iris_X_train,iris_y_train)
#Testing
print knn.predict(iris_X_test)
#Diabetes data prepare(age, sex, weight, blood pressure)
diabetes = datasets.load_diabetes()
diabetes_X_train = diabetes.data[:-20]
diabetes_X_test  = diabetes.data[-20:]
diabetes_y_train = diabetes.target[:-20]
diabetes_y_test  = diabetes.target[-20:]
print iris_y_test
#Curse of dimensionality
#2.2.2.2 Linear Model:from regression to sparsity
from sklearn import linear_model
regr = linear_model.LinearRegression()
print regr.fit(diabetes_X_train,diabetes_y_train)
print regr.coef_
#The mean square error
print np.mean((regr.predict(diabetes_X_test)-diabetes_y_test)**2)
#Explained variance score: 1 is perfect prediction
#and o means that there is no linear relationship between X and y.
print regr.score(diabetes_X_test, diabetes_y_test)

#Shrinkage
X = np.c_[.5,1].T
y = [.5,1]
test = np.c_[0,2].T
regr = linear_model.LinearRegression()
#Plot it
import pylab as pl
pl.figure()

np.random.seed(0)
for _ in range(6):
    this_X = .1*np.random.normal(size=(2,1))+X
    regr.fit(this_X,y)
    pl.plot(test,regr.predict(test))
    pl.scatter(this_X, y, s=3)

pl.show()
#Ridge regression
regr = linear_model.Ridge(alpha=.1)
pl.figure()

np.random.seed(0)
for _ in range(6):
    this_X = .1*np.random.normal(size=(2,1))+X
    regr.fit(this_X,y)
    pl.plot(test,regr.predict(test))
    pl.scatter(this_X,y,s=3)
pl.show()

#bias/variance tradeoff
alphas = np.logspace(-4, -1, 6)
print [regr.set_params(alpha=alpha).fit(diabetes_X_train,diabetes_y_train).score(diabetes_X_test,diabetes_y_test) for alpha in alphas]

#Sparsity
regr = linear_model.Lasso()
scores = [regr.set_params(alpha=alpha).fit(diabetes_X_train, diabetes_y_train).score(diabetes_X_test, diabetes_y_test) for alpha in alphas]
best_alpha = alphas[scores.index(max(scores))]
regr.alpha = best_alpha
print regr.fit(diabetes_X_train, diabetes_y_train)

print regr.coef_

#2.2.2.4. Classification
##LogisticRegression
logistic = linear_model.LogisticRegression(C=1e5)
print logistic.fit(iris_X_train, iris_y_train)

#2.2.2.3. Support vector machines(SVMs)
#2.2.2.3.1. Linear SVMs
#For many estimators, including the SVMs, having datasets with unit standard deviation for each feature is important to get good prediction.
from sklearn import svm
svc = svm.SVC(kernel='linear')
print svc.fit(iris_X_train, iris_y_train)

