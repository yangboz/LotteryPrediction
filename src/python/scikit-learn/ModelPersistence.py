from sklearn import svm
from sklearn import datasets
clf = svm.SVC()
iris = datasets.load_iris()
X,y = iris.data,iris.target
print clf.fit(X, y)
import pickle
s = pickle.dumps(clf)
clf2 = pickle.loads(s)
print clf2.predict(X[0])
print y[0]