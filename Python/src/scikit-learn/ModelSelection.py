#2.2.3.1,the bigger is better
from sklearn import datasets,svm
digits = datasets.load_digits()
X_digits = digits.data
y_digits = digits.target
svc = svm.SVC(C=1,kernel='linear')
print svc.fit(X_digits[:-100], y_digits[:-100]).score(X_digits[-100:],y_digits[-100:])
#Split the dataset in folds to get better measure of prediction accuracy
import numpy as np
X_folders = np.array_split(X_digits, 3)
y_folders = np.array_split(y_digits,3)
scores = list()
#KFold cross validation
for k in range(3):
    #We use 'list' to copy ,in order to 'pop' later on
    X_train = list(X_folders)
    X_test = X_train.pop(k)
    X_train = np.concatenate(X_train)
    y_train = list(y_folders)
    y_test = y_train.pop(k)
    y_train = np.concatenate(y_train)
    scores.append(svc.fit(X_train,y_train).score(X_test,y_test))
print scores
#2.2.3.2. Cross-validation generators
from sklearn import cross_validation
k_fold = cross_validation.KFold(n=6,n_folds=3,indices=True)
for train_indices,test_indices in k_fold:
    print 'Train:%s | test:%s' % (train_indices,test_indices)
#
kfold = cross_validation.KFold(len(X_digits), n_folds=3)
print [svc.fit(X_digits[train], y_digits[train]).score(X_digits[test], y_digits[test]) for train, test in kfold]
#print cross_validation.cross_val_score(svc, X_digits, y_digits, cv=kfold, n_jobs=-1)
#2.2.3.3.1. Grid-search
from sklearn.grid_search import GridSearchCV
gammas = np.logspace(-6, -1, 10)
clf = GridSearchCV(estimator=svc,param_grid=dict(gamma=gammas))
print clf.fit(X_digits[:1000], y_digits[:1000])
print clf.best_score_
print clf.best_estimator_.gamma
#Prediction performace on test set is not as good as on train set
print clf.score(X_digits[1000:], y_digits[1000:])
#2.2.3.3.2. Cross-validated estimators
from sklearn import linear_model,datasets
lasso = linear_model.LassoCV()
diabetes = datasets.load_diabetes()
X_diabetes = diabetes.data
y_diabetes = diabetes.target
print lasso.fit(X_diabetes,y_diabetes)
#The estimator chose automatically its lambda:
print lasso.alpha_