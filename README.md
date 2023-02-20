# Preface

Predicting is making claims about something that will happen, often based on information from past and from current state.
![Screenshot of "Prediction"](http://www.obitko.com/tutorials/neural-network-prediction/images/prediction.gif)

Everyone solves the problem of prediction every day with various degrees of success. For example weather, harvest, energy consumption, movements of forex (foreign exchange) currency pairs or of shares of stocks, earthquakes, and a lot of other stuff needs to be predicted.
...

now I am taking course to Wharton's Business Analytics: From Data to Insights program! 


Week 2: Module Introduction and Instructions
By the end of Week 2 - Descriptive Analytics: Describing and Forecasting Future Events, you should be able to:

Use historical data to estimate forecasts for future events using trends and seasonality
Calculate the descriptive sample statistics for demand distributions
Discuss drawbacks of using Moving Averages Forecasting
Key Activities for Week 2
Videos 1-29
Practice Quiz 1: Newsvendor Concepts
Practice Quiz 2: Moving Averages
Practice Quiz 3: Trends and Seasonality
Week 2: Knowledge Check
Assignment 2: iD Fresh Food Case Study
All of the above activities should be completed by Thursday, July 14, 2022, by 4:29 PM UTC.

Spreadsheet Models

In this week, Professor Veeraraghavan uses Excel spreadsheets to demonstrate some of the forecasting models. The spreadsheets that he uses are added in the respective video pages.

You can also find all the spreadsheets collated in the Week 2: Spreadsheets page along with their solution files. For the best learning experience, we recommend that you work on the spreadsheet models along with the professor before you download the solution files.



# descriptive Analytics

## by chatgpt

write down an AI transformer  architecture model to perform time-serials lottery data analytics program
Here is one potential approach to writing an AI transformer architecture model for performing time-series lottery data analytics:

One possible architecture for an AI model to perform time-series lottery data analytics could be a recurrent neural network (RNN) model. Here's a high-level overview of the architecture:


### Data Preprocessing: The lottery data would need to be preprocessed before feeding into the model. This includes steps such as converting the data into a suitable format (e.g. numerical), handling missing values, and scaling the data to a uniform range.

### Input Layer: The input layer of the RNN would take in the preprocessed lottery data as a time-series sequence. Each data point in the sequence represents the lottery winning numbers for a particular drawing.


### Recurrent Layers: The RNN would have multiple recurrent layers, with each layer processing one time step of the input sequence. The output of each recurrent layer is fed back into the next recurrent layer. This allows the model to learn long-term dependencies in the data.


#### Dropout Layer: To prevent overfitting, a dropout layer can be added after the recurrent layers. This randomly drops out some of the neurons during training, forcing the remaining neurons to learn more robust features.
Dense Layer: A dense layer can be added after the dropout layer to reduce the dimensionality of the output and generate a final prediction for the next winning lottery numbers.

#### Output Layer: The output layer would take the output of the dense layer and generate a set of predicted winning numbers for the next drawing.
Loss Function: The model would be trained using a suitable loss function, such as mean squared error or cross-entropy loss, to measure the difference between the predicted winning numbers and the actual winning numbers.
Optimization Algorithm: An optimization algorithm, such as stochastic gradient descent, would be used to update the weights of the model during training.
Overall, this RNN architecture can learn patterns in the lottery data over time and generate predictions for the next winning numbers based on those patterns.




### Collect and preprocess the data: 

Gather a large dataset of past lottery results, including the numbers drawn and the date of the draw. Preprocess the data to remove any errors or inconsistencies, and format it for use in the model.
Split the data into training and testing sets: Use a portion of the data for training the model, and reserve the rest for testing the model's performance.
Implement the transformer architecture: Use the transformer architecture, which is a type of deep learning model designed for natural language processing tasks, to analyze the time-series data. The transformer architecture consists of multiple layers of self-attention and fully connected neural network layers.

Train the model: Use the training data to train the model, adjusting the model's parameters as needed to improve its accuracy.

Test the model: Use the testing data to evaluate the model's performance and fine-tune it as needed.

Deploy the model: Deploy the trained model in a production environment, where it can be used to analyze real-time lottery data and make predictions about future draws.


This is just one possible approach to building an AI transformer architecture model for time-series lottery data analytics. There may be other approaches that could also be effective, depending on the specific requirements and constraints of the project.



# Predictive Analytics

With classification, deep learning is able to establish correlations between, say, pixels in an image and the name of a person. You might call this a static prediction. By the same token, exposed to enough of the right data, deep learning is able to establish correlations between present events and future events. The future event is like the label in a sense. Deep learning doesn’t necessarily care about time, or the fact that something hasn’t happened yet. Given a time series, deep learning may read a string of number and predict the number most likely to occur next.


# by chatgpt


write down an AI transformer  architecture model to perform time-serials lottery data analytics program
Here is one potential approach to writing an AI transformer architecture model for performing time-series lottery data analytics:

## Collect and preprocess the data: 

Gather a large dataset of past lottery results, including the numbers drawn and the date of the draw. Preprocess the data to remove any errors or inconsistencies, and format it for use in the model.
Split the data into training and testing sets: Use a portion of the data for training the model, and reserve the rest for testing the model's performance.
Implement the transformer architecture: Use the transformer architecture, which is a type of deep learning model designed for natural language processing tasks, to analyze the time-series data. The transformer architecture consists of multiple layers of self-attention and fully connected neural network layers.


## Train the model: 

Use the training data to train the model, adjusting the model's parameters as needed to improve its accuracy.

## Test the model: 

Use the testing data to evaluate the model's performance and fine-tune it as needed.
Deploy the model: Deploy the trained model in a production environment, where it can be used to analyze real-time lottery data and make predictions about future draws.


This is just one possible approach to building an AI transformer architecture model for time-series lottery data analytics.


There may be other approaches that could also be effective, depending on the specific requirements and constraints of the project.

## dataVs:

### using Flash

![Screenshot of "LotteryPrediction"](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/dataV/Flex/src/assets/screenshots/lp.jpg)
![Screenshot of "LotteryPrediction"](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/dataV/Flex/src/assets/screenshots/lp_time_slice.jpg)
![Screenshot of "LotteryPrediction"](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/dataV/Flex/src/assets/screenshots/lp_time_slice_compare.jpg)

## data visualization

  ## using fbProphet:
  
![fbProphet](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/dataV/python/fbProphet.jpg)
![darts](https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/dataV/python/darts.jpg)

  ## todos:
  
streamlit: https://docs.streamlit.io/en/stable/api.html#display-data

plotly:https://plotly.com/python/time-series/

# Live Demos

https://yangboz.github.io/labs/lp/LotteryPrediction_AmCharts_R.swf 
https://yangboz.github.io/labs/lp/LotteryPrediction_AmCharts_RCX.swf
https://yangboz.github.io/labs/lp/LotteryPrediction_FlexCharts.swf


## notes

besides of following  "law of proability","Probability: Independent Events", there are still "Saying "a Tail is due", or "just one more go, my luck is due to change" is called The Gambler's Fallacy" existed.

here we are not garantee to help with you to  win lottery prize. if you got lucky from here. please donate here, we also donate to charities.

## Please donate to ETH: 0xa45542927c06591a224c28ca3596a3bD56C499fb or bitcoin://13dCHc2EjAig5dejcmxYFnWLwJ5AmJb6q8?amount=0

[howto install and use it?]https://github.com/yangboz/LotteryPrediction/wiki#how-can-i-install-and-use-it

## custom company service mailto: z@smartkit.club, with your sample history lottery-data, and must have plain text of game-rule's introduction.

## Refs:

http://deeplearning4j.org/usingrnns.html

http://www.scriptol.com/programming/list-algorithms.php

http://www.ipedr.com/vol25/54-ICEME2011-N20032.pdf

http://www.brightpointinc.com/flexdemos/chartslicer/chartslicersample.html

http://stats.stackexchange.com/questions/68662/using-deep-learning-for-time-series-prediction


[Python logutils](https://code.google.com/p/logutils/)

[Python data analysis_pandas](http://pandas.pydata.org/)

[Python data minning_orange](http://orange.biolab.si/)

[Python data-mining and pattern recognition packages](http://www.researchpipeline.com/wordpress/2011/02/15/python-data-mining-packages/)

[Python Machine Learning Packages](http://web.media.mit.edu/~stefie10/technical/pythonml.html)

[Conference on 100 YEARS OF ALAN TURING AND 20 YEARS OF SLAIS](http://ailab.ijs.si/dunja/TuringSLAIS-2012/)

[USA Draft Lottery 1970](http://lib.stat.cmu.edu/DASL/Stories/DraftLottery.html )

[Python Scikit-Learn](http://scikit-learn.org/)

[Python Multivarite Pattern Analysis](http://www.pymvpa.org/)

[BigML](https://bigml.com)

[Patsy](http://patsy.readthedocs.org)

[StatModel](http://statsmodels.sourceforge.net/)

[Neural Lotto — Lottery Drawing Predicting Method](http://www.neural-lotto.net/index.php/en/)

[Random.org](http://www.random.org/clients/http/)

[Predictive Analytics Guide](http://www.predictiveanalyticsworld.com/predictive_analytics.php)
 
[TensorFlow Tutorial for Time Series Prediction:] (https://github.com/tgjeon/TensorFlow-Tutorials-for-Time-Series)

# Roadmap:

## landing page: 

## PoC 

## API public service:

## Phase I.Graphics: Looking at Data; 

1.A single variable:Shape and Distribution; ( Dot/Jitter plots,Histograms and Kernel Density Estimates,Cumulative Distribution Function,Rank-Order...)

2.Two variables:Establishing Relationships; ( Scatter plots,Conquering Noise,Logarithmic Plots,Banking...)

3.Time as a variable: Time-Series Analysis; (Smoothing,Correlation,Filters,Convolutions..)

4.More than two variables;Graphical Multivariate Analysis;(False-color Plots,Multi plots...)

5.Intermezzo:A Data Analysis Session;(Session,gnuplot..)

6...

## Phase II.Analytics: Modeling Data;

1.Guesstimation and the back of envelope;

2.Models from scaling arguments;

3.Arguments from probability models;

4...

## Phase III.Computation: Mining Data;

1.Simulations;

2.Find clusters;

3.Seeing the forest for the decision trees;

4....

## Phase IV.Applications: Using Data;

1.Reporting, BI (Business Intelligence),Dashboard;

2.Financial calculations and modeling;

3.Predictive analytics;

4....

=======
# Draft plan

Phase I.Graphics: Looking at Data; 

1.A single variable:Shape and Distribution; ( Dot/Jitter plots,Histograms and Kernel Density Estimates,Cumulative Distribution Function,Rank-Order...)

2.Two variables:Establishing Relationships; ( Scatter plots,Conquering Noise,Logarithmic Plots,Banking...)

3.Time as a variable: Time-Series Analysis; (Smoothing,Correlation,Filters,Convolutions..)

4.More than two variables;Graphical Multivariate Analysis;(False-color Plots,Multi plots...)

5.Intermezzo:A Data Analysis Session;(Session,gnuplot..)

6...

Phase II.Analytics: Modeling Data;

1.Guesstimation and the back of envelope;

2.Models from scaling arguments;

3.Arguments from probability models;

4...

Phase III.Computation: Mining Data;

1.Simulations;

2.Find clusters;

3.Seeing the forest for the decision trees;

4....

Phase IV.Applications: Using Data;

1.Reporting, BI (Business Intelligence),Dashboard;

2.Financial calculations and modeling;

3.Predictive analytics;

4....

# TODO:

 fbprophet model finetune: https://facebook.github.io/prophet/docs/quick_start.html
 
 
 ## ChatGPT 
 
 according to  ChatGPT's advice:
 
 Writing a lottery prediction program can be a challenging task as it involves analyzing past lottery results, identifying patterns, and using statistical techniques to make predictions about future draws.

Here are some steps you can follow to write a lottery prediction program:

Collect data: Gather a large dataset of past lottery results, including the numbers drawn and the date of the draw.


Preprocess data: Clean and organize the data to remove any errors or inconsistencies.


Analyze data: Use statistical techniques such as frequency analysis, clustering, and regression to identify patterns and trends in the data.


Build a model: Use the insights gained from the data analysis to build a predictive model that can make predictions about future lottery draws.


Test the model: Use the model to make predictions on a separate dataset of past lottery results and evaluate its performance.

Fine-tune the model: If necessary, make adjustments to the model based on the results of the testing phase to improve its accuracy.


Implement the program: Write the code for the lottery prediction program, including any necessary user interfaces and input/output mechanisms.


It is important to note that the accuracy of a lottery prediction program 

will depends on the quality of the data, 

the complexity of the model,


and the skill of the developer. 


There is no guarantee that a lottery prediction program will be successful,



and using such a program for financial gain may not be legal in some jurisdictions.
 
 
 
 
 ## References
 
TensorFlow Tutorial for Time Series Prediction: https://github.com/tgjeon/TensorFlow-Tutorials-for-Time-Series

Time Series Forecasting made easy with Darts 

https://unit8co.github.io/darts/#:~:text=darts%20is%20a%20Python%20library,%2C%20similar%20to%20scikit%2Dlearn.



ETSformer: Exponential Smoothing Transformers for Time-Series Forecasting 

https://blog.salesforceairesearch.com/etsformer-time-series-forecasting/


## papers

https://www.datascience.us/predicting-success-in-lottery-with-deep-learning/

## free version support and trail

https://github.com/yangboz/LotteryPrediction/wiki

## Commercial support and training

Commercial support and training is available , please mailto z@smartkit.club  with your historic-data and plain english description.

##
