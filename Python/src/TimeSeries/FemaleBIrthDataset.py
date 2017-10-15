#@see: https://machinelearningmastery.com/make-predictions-time-series-forecasting-python/
from pandas import Series
from matplotlib import pyplot
import numpy as np
from statsmodels.tsa.ar_model import AR
from sklearn.metrics import mean_squared_error

series = Series.from_csv('daily-total-female-births-in-cal.csv',header=0)
print(series.head())
series.plot()
pyplot.show()
# pyplot.savefig('./FemaleBirthDataset.png')

#1. Select Time Series Forecast Model
# value(t) = obs(t) - obs(t - 1)
# create a difference of the dataset
def difference(dataset):
    diff = list()
    for i in range(1,len(dataset)):
        value = dataset[i]-dataset[i-1]
        diff.append(value)
    return np.array(diff)
# make prediction with regressive coefficients and lag observe value
def prediction(coef,history):
    yhat = coef[0]
    for i in range(1,len(coef)):
        yhat += coef[i]* history[-i]
    return yhat
# split dataset
X = difference(series.values)
size = int(len(X)*0.66)
train,test = X[0:size],X[size:]
# train autoregression model
model = AR(train)
model_fit = model.fit(maxlag=6,disp=False)
window = model_fit.k_ar
coef = model_fit.params
# walk forward over the time steps in the test
history = [train[i] for i in range(len(train))]
predictions = list()
for t in range(len(test)):
    yhat = prediction(coef,history)
    obs = test[t]
    predictions.append(yhat)
    history.append(obs)
error = mean_squared_error(test,predictions)
print('Test MSE: %.3f' % error)
# plot
pyplot.plot(test)
pyplot.plot(predictions, color='red')
pyplot.show()
# pyplot.savefig('./FemaleBirthPrediction.png')

# 2. Finalize and Save Time Series Forecast Model



