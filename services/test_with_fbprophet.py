import pandas as pd

from pandas import DataFrame
from pandas import to_datetime
from fbprophet import Prophet
import matplotlib.pyplot as plt

mynames=["ds","y"]
df = pd.read_csv('ds_2003_2017_y_blueball.csv',header=None,names=mynames,sep=',')
print(df.shape)
print(df.head())
df['cap'] = 16
m = Prophet(growth='linear',changepoint_range=0.05)
m.fit(df)  # training model

future = m.make_future_dataframe(freq='D',periods=365*4+7*3)  # containing the dates for which a prediction is to be made
future['cap'] = 16
forecast = m.predict(future)

# summarize the forecast
print(forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail())
#plot
m.plot(forecast) # Fig1
# plt.show()
fig2 = m.plot_components(forecast)
plt.grid()
plt.legend(loc=2, prop={'size': 6})
plt.legend(fontsize="x-large")
plt.show()


# define the period for which we want a prediction
# future = list()
# for i in range(9, 11):
# 	date = '2021-%02d' % i
# 	future.append([date])
# 	future = DataFrame(future)
# 	future.columns = ['ds']
# 	future['ds']= to_datetime(future['ds'])

# 	# use the model to make a forecast
# 	model = Prophet(growth='linear')
# 	forecast = model.predict(future)
# 	# summarize the forecast
# 	print(forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].head())
# 	# plot forecast
# 	model.plot(forecast)
# 	pyplot.show()