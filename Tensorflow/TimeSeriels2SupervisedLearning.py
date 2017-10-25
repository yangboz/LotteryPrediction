import pandas
import numpy
# @see: https://machinelearningmastery.com/convert-time-series-supervised-learning-problem-python/

df_csv = pandas.read_csv('./data/red_bule_balls_2003.csv',names=['id', 'r1', 'r2', 'r3', 'r4', 'r5','r6','b1'])
print(df_csv)

def series_to_supervised(data, n_in=1, n_out=1, dropnan=True):
	"""
	Frame a time series as a supervised learning dataset.
	Arguments:
		data: Sequence of observations as a list or NumPy array.
		n_in: Number of lag observations as input (X).
		n_out: Number of observations as output (y).
		dropnan: Boolean whether or not to drop rows with NaN values.
	Returns:
		Pandas DataFrame of series framed for supervised learning.
	"""
	n_vars = 1 if type(data) is list else data.shape[1]
	df = pandas.DataFrame(data)
	cols, names = list(), list()
	# input sequence (t-n, ... t-1)
	for i in range(n_in, 0, -1):
		cols.append(df.shift(i))
		names += [('var%d(t-%d)' % (j+1, i)) for j in range(n_vars)]
	# forecast sequence (t, t+1, ... t+n)
	for i in range(0, n_out):
		cols.append(df.shift(-i))
		if i == 0:
			names += [('var%d(t)' % (j+1)) for j in range(n_vars)]
		else:
			names += [('var%d(t+%d)' % (j+1, i)) for j in range(n_vars)]
	# put it all together
	agg = pandas.concat(cols, axis=1)
	agg.columns = names
	# drop rows with NaN values
	if dropnan:
		agg.dropna(inplace=True)
	return agg

# 1.One-Step Univariate Forecasting
# values = [x for x in range(10)]
# data = series_to_supervised(values)
# data = series_to_supervised(values, 3)
values = df_csv.values

# 2.Multi-Step or Sequence Forecasting

data = series_to_supervised(values, 2, 2)
print(data)

# 3.Multivariate Forecasting
# raw = pandas.DataFrame()
# raw['ob1'] = [x for x in range(10)]
# raw['ob2'] = [x for x in range(50, 60)]
# values = raw.values
data = series_to_supervised(values)
print(data)

data = series_to_supervised(values, 1, 2)
print(data)
