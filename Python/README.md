Using Python based Pandas/SciKit for ingest/anlysis/visualize lottery historic data;

### Process for Making a Prediction

A lot is written about how to tune specific time series forecasting models, but little help is given to how to use a model to make predictions.

Once you can build and tune forecast models for your data, the process of making a prediction involves the following steps:

#### Model Selection. This is where you choose a model and gather evidence and support to defend the decision.

Dataset(daily-total-female-births-in-cal.csv) preview:

![Screenshot of "Dataset"](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/Python/src/TimeSeries/FemaleBirthDataset.png)

Dataset prediction:

![Screenshot of "Prediction"](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/Python/src/TimeSeries/FemaleBirthPrediction.png)

#### Model Finalization. The chosen model is trained on all available data and saved to file for later use.
#### Forecasting. The saved model is loaded and used to make a forecast.
#### Model Update. Elements of the model are updated in the presence of new observations.

Refs:

https://machinelearningmastery.com/make-predictions-time-series-forecasting-python/
