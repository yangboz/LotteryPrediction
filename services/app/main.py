import pandas as pd
from pandas import DataFrame
from pandas import to_datetime
from fbprophet import Prophet
import matplotlib.pyplot as plt

from typing import Optional
from fastapi import FastAPI,Query
from fastapi import FastAPI, File, UploadFile
from datetime import datetime

from typing import List
app = FastAPI(title="yangboz/LotteryPrediction",
    description="How can i install and use it? #0.now.#1.uploadfile.#2.fit_model，#3.predict",
    version="0.0.1",
    terms_of_service="https://github.com/yangboz/LotteryPrediction",
    contact={
        "name": "LotteryPrediction with fbprophet",
        "url": "https://github.com/yangboz/LotteryPrediction",
        "email": "z@smartkit.club",
    },
    license_info={
        "name": "Apache 2.0",
        "url": "https://www.apache.org/licenses/LICENSE-2.0.html",
    },)
#global vars


@app.get("/")
def now():
    return {"hello": "LotteryPrediction"}

@app.post("/uploadfile/")
async def upload_your_history_data(file: UploadFile = File(...)):
	mynames=["ds","y"]

	app.df = pd.read_csv(file.filename,header=None,names=mynames,sep=',')
	# pd.set_option("display.max_rows", None, "display.max_columns", None)
	# print("app.df:",app.df.to_string())
	app.firstRow = app.df.loc[0,:]
	app.lastRow = app.df.iloc[-1]
	print("app.lastRow:",app.lastRow)
	app.firstRowDs = app.firstRow['ds']
	print("app.firstRowDs:",app.firstRowDs)
	app.lastRowDs = app.lastRow['ds']
	print("app.firstRow:",app.firstRow)
	app.firstRowds = app.firstRow['ds']
	
	app.lastRowds = app.lastRow['ds']
	print("app.lastRowDs:",app.lastRowds)
	return{
	      "filename": file.filename,
	      "shape":app.df.shape,
	      "fist":app.firstRowDs,
	      "last":app.lastRowDs
		   }

@app.put("/fit/")
def fit_model(growth: Optional[str] = 'linear',range: Optional[float] = 0.05):
    app.model = Prophet(growth=growth,changepoint_range=range)
    app.model.fit(app.df)  # training model
    return {"success": " fit with fbprophet"}

@app.get("/predict/{futureDay}")

def model_predict(futureDay:Optional[str] = '2021-12-04'):
  futureDatetime = datetime.fromisoformat(futureDay)

  print("futureDatetime:",futureDatetime)
  historytime = datetime.strptime(app.lastRowDs,'%Y/%m/%d')
  print("historytime:",historytime)
  calc_periods= futureDatetime-historytime
  print("calc_periods:",calc_periods)
  future = app.model.make_future_dataframe(freq='D',periods=calc_periods)  # containing the dates for which a prediction is to be made
  future['cap'] = 16
  forecast = app.model.predict(future)
# summarize the forecast
  model_predict = forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']]
  tail = model_predict.tail()
  print(model_predict.tail())
  return {"predict": " with fbprophet"}

# mynames=["ds","y"]
# df = pd.read_csv('ds_2003_2017_y_blueball.csv',header=None,names=mynames,sep=',')
# print(df.shape)
# print(df.head())
# df['cap'] = 16
# m = Prophet(growth='linear',changepoint_range=0.05)
# m.fit(df)  # training model

# future = m.make_future_dataframe(freq='D',periods=365*4+7*3)  # containing the dates for which a prediction is to be made
# future['cap'] = 16
# forecast = m.predict(future)

# # summarize the forecast
# print(forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail())
# #plot
# m.plot(forecast) # Fig1
# # plt.show()
# fig2 = m.plot_components(forecast)
# plt.grid()
# plt.legend(loc=2, prop={'size': 6})
# plt.legend(fontsize="x-large")
# plt.show()


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