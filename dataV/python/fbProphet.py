
# check prophet version
import fbprophet
# from matplotlib import pyplot
from pandas import to_datetime
from pandas import DataFrame
from matplotlib import pyplot
from pandas import Series
from fbprophet import Prophet
# print version number
import fbprophet
# print version number
print('Prophet %s' % fbprophet.__version__)


from pandas import read_csv
# load data
path = './03001-17132.csv'

header_list = ["ds", "rball1"]
header_list = ["ds", "blue_ball"]
df = read_csv(path, header=0,sep=',', delimiter=None, names=header_list, usecols = [1,15])
print(df)

subdf = df.iloc[0:100]

print(subdf.shape)
print(subdf)

# df.plot(style='k.')
# py plot.show()
# summarize shape
print(df.shape)
# print(df.iloc[:1])
# print(df.iloc[:2])

# print(df[0]);
# df.columns = ['ds', 'y']
# show first few rows
print(df.head())
# df = read_csv(path, header=0)
# plot the time series
# df.plot()
# pyplot.show()



# prepare expected column names
df.columns = ['ds', 'y']
df['ds']= to_datetime(df['ds'])
# define the model
model = Prophet()
# fit the model
model.fit(df)

# define the period for which we want a prediction
future = list()
for i in range(1, 13):
	date = '2003/%02d' % i
	future.append([date])
future = DataFrame(future)
future.columns = ['ds']
future['ds']= to_datetime(future['ds'])
# use the model to make a forecast
forecast = model.predict(future)

# summarize the forecast
print(forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].head())
# plot forecast
model.plot(forecast)
pyplot.show()






