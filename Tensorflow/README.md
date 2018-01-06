# Preface

![Screenshot of "Prediction"](http://www.obitko.com/tutorials/neural-network-prediction/images/prediction.gif)

TensorFlow Tutorial for Time Series Prediction(AR、Anomaly Mixture AR、LSTM).


Feedforward neural networks applied to time series prediction are usually trained to predict the next time step x(t + 1) as a function of m previous values, x(t) := (x(t), x(t + 1),…, x(t − m + 1)), which, if a sum-of-squares error function is chosen, results in predicting the conditional mean 〈y|x(t)〉. However, https://www.sciencedirect.com/science/article/pii/S0893608096000627

# Refs:

https://github.com/tgjeon/TensorFlow-Tutorials-for-Time-Series

https://github.com/hzy46/TensorFlow-Time-Series-Examples

# Screen shots
2003 red_blue_balls trend:

![Screenshot of "Trend"](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/Tensorflow/predict_result_period_trend.png)

2003 red_blue_balls prediction:

![Screenshot of "Prediction"](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/Tensorflow/predict_result_redblueballs.png)
