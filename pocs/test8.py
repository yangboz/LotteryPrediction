import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from fbprophet import Prophet

#fbprophet installation
#conda install -c anaconda ephem 
#conda install -c conda-forge pystan
#conda install -c conda-forge fbprophet

df = pd.read_csv("datasets/stock_trading_data.csv")

print(df.shape)
print(df.head())
#we will take only 5 columns
df = df.iloc[:,:5]

#fixed the datetime column
df["Date"] = pd.to_datetime(df["Date"])

print(df.head(5))
# df = dataset = pd.read_excel('datasets/Dec. 2023_p3_130.xlsx', index_col=0,parse_dates = True,  sheet_name='P3',usecols=[0, 2, 3,4])
print(df.shape)
print(df.head())

#we will take only 5 columns
df = df.iloc[:,:5]

#fixed the datetime column
# df["Date"] = pd.to_datetime(df["DATE"])

#Divide the data into train and test
test_size =np.round(df.shape[0] *30/100).astype(int)
df1_train = df.iloc[test_size:,:]
df1_test = df.iloc[:test_size,:]
df1_train.dtypes

#let's plot the graph aand try to visualize for all columns based on date
plt.figure(figsize=(10,8))
figure,axes = plt.subplots(nrows=2,ncols=2)
axes[0,0].plot(df1_train["Date"],df1_train["Open"],label="Open")
axes[0,1].plot(df1_train["Date"],df1_train["High"],label="High")
axes[1,0].plot(df1_train["Date"],df1_train["Low"],label="Low")
axes[1,1].plot(df1_train["Date"],df1_train["Close"],label="Close")
plt.legend()

#prepare the dateset for FBprophet
df1_train.rename(columns={"Open":'y',"Date":'ds'},inplace=True)
df1_train.head(5)
model = Prophet(interval_width=0.9)
model.add_regressor('High',standardize=False)
model.add_regressor('Low',standardize=False)
model.add_regressor('Close', standardize=False)
model.fit(df1_train)

model.params

#understanding the model fit-------------------------------
df1_train_2 = df1_train[["ds","High","Low","Close"]] #we will be predicting 'y' i.e."Open"
forecast1_train = model.predict(df1_train_2)
forecast1_train = forecast1_train[['ds','yhat']]
df_model_fit = pd.concat((forecast1_train['yhat'],df1_train.reset_index()),axis=1).reset_index()

#Visualize it 
plt.figure(figsize=(8,6))
plt.plot(df_model_fit['ds'],df_model_fit['y'],color='red',label='actual')
plt.plot(df_model_fit['ds'],df_model_fit['yhat'],color='red',label='Forecasted')
plt.legend()

#-------------------------------------------------------------
#create an test dataframe
df1_test.rename(columns={"Open":'y',"Date":'ds'},inplace=True)
df1_test.head(5)
df1_test_2 = df1_test[["ds","High","Low","Close"]] #predicting 'y'i.e."Open"
df1_test_2

forecast1_test=model.predict(df1_test_2)
forecast1_test = forecast1_test[['ds','yhat']] #extract the required column
df_testdata_fit = pd.concat((forecast1_test['yhat'],df1_test.reset_index()),axis=1).reset_index()

#Visualize it 
plt.figure(figsize=(8,6))
plt.plot(df_testdata_fit['ds'],df_testdata_fit['y'],color='red',label='actual')
plt.plot(df_testdata_fit['ds'],df_testdata_fit['yhat'],color='blue',label='Forecasted')
plt.legend()

#make futuredate--approach--------------------
future = model.make_future_dataframe(periods=377)
future.tail()
future_prediction = model.predict(future)
print("future_prediction:",future_prediction)
#will not work it will throw an error of missing other independent variables