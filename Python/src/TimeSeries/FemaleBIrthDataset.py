#@see: https://machinelearningmastery.com/make-predictions-time-series-forecasting-python/
from pandas import Series
from matplotlib import pyplot
import numpy as np
from statsmodels.tsa.ar_model import AR
from statsmodels.tsa.ar_model import ARResults
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
# save model to file
model_fit.save('ar_model.pkl')
# save different data_set
np.save('ar_data.npy',X)
# save last observe value.
np.save('ar_obs.npy',[series.values[:-1]])

# load AR model

loaded = ARResults.load('ar_model.pkl')
print(loaded.params)
# get real observation
observation = 48
# load the saved data
data = np.load('ar_data.npy')
last_ob = np.load('ar_obs.npy')
# update and save differenced observation
diffed = observation - last_ob[0]
data = np.append(data, [diffed], axis=0)
np.save('ar_data.npy', data)
# update and save real observation
last_ob[0] = observation
np.save('ar_obs.npy', last_ob)
# 3. Make a Time Series Forecast
# predictions = model.predict(start=len(last_ob),end=len(lag),params=coef)
predictions = prediction(coef,data)
# transform prediction
yhat = predictions+last_ob[0]
print("transform predictions: %f" % yhat)
# 4. Update Forecast Model

