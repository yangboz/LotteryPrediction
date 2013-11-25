import numpy as np
import pandas as pd
import statsmodels.formula.api as smf
#Load data
url = './data/Guerry.csv'
data = pd.read_csv(url)
#Fit regression model(using natural log of one of the regression)
results = smf.ols('Lottery ~ Literacy + np.log(Pop1831)', data=data).fit()
#Inspect the results
print results.summary()
#Using numpy
import numpy as np
import statsmodels.api as sm
#Generate artifical data(2 regressors+constant)
nobs = 100
X = np.random.random((nobs,2))
X = sm.add_constant(X)
beta = [1,.1,.5]
e = np.random.random(nobs)
y = np.dot(X,beta) + e
#Fit regression model
results = sm.OLS(y,X).fit()
#Inspect the results
print results.summary()