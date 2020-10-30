# Preface

Predicting is making claims about something that will happen, often based on information from past and from current state.
![Screenshot of "Prediction"](http://www.obitko.com/tutorials/neural-network-prediction/images/prediction.gif)

Everyone solves the problem of prediction every day with various degrees of success. For example weather, harvest, energy consumption, movements of forex (foreign exchange) currency pairs or of shares of stocks, earthquakes, and a lot of other stuff needs to be predicted.
...

# Predictive Analytics

With classification, deep learning is able to establish correlations between, say, pixels in an image and the name of a person. You might call this a static prediction. By the same token, exposed to enough of the right data, deep learning is able to establish correlations between present events and future events. The future event is like the label in a sense. Deep learning doesn’t necessarily care about time, or the fact that something hasn’t happened yet. Given a time series, deep learning may read a string of number and predict the number most likely to occur next.

# Screen shots

![Screenshot of "LotteryPrediction"](https://raw.github.com/yangboz/LotteryPrediction/master/Flex/src/assets/screenshots/lp.jpg)
![Screenshot of "LotteryPrediction"](https://raw.github.com/yangboz/LotteryPrediction/master/Flex/src/assets/screenshots/lp_time_slice.jpg)
![Screenshot of "LotteryPrediction"](https://raw.github.com/yangboz/LotteryPrediction/master/Flex/src/assets/screenshots/lp_time_slice_compare.jpg)

![Snapshot of "Dot plotting"](https://raw.github.com/yangboz/LotteryPrediction/master/Python/src/snapshots/blue_balls_dot_plot.png)
![Snapshot of "Histogram plotting"](https://raw.github.com/yangboz/LotteryPrediction/master/Python/src/snapshots/blue_balls_histogram_plot.png)
![Snapshot of "KDE plotting"](https://raw.github.com/yangboz/LotteryPrediction/master/Python/src/snapshots/blue_balls_gussian_kde_plot.png)
![Snapshot of "CDF plotting"](https://raw.github.com/yangboz/LotteryPrediction/master/Python/src/snapshots/blue_balls_cdf_plot.png)
![Snapshot of "Probability plotting"](https://raw.github.com/yangboz/LotteryPrediction/master/Python/src/snapshots/blue_balls_probability_plot.png)

# Live Demos

https://yangboz.github.io/labs/lp/LotteryPrediction_AmCharts_R.swf 
https://yangboz.github.io/labs/lp/LotteryPrediction_AmCharts_RCX.swf
https://yangboz.github.io/labs/lp/LotteryPrediction_FlexCharts.swf

# Refs:

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

# Roadmap:

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

#TODO:

1.Using D3JS Chart to visualization the data; (http://techslides.com/over-1000-d3-js-examples-and-demos/);

2.Using Tableau software trail and error; (http://www.tableausoftware.com/)

3.Using PredictionIO API; (http://prediction.io)

4.Using Free Tempo-DB for time series database storage ; (https://tempo-db.com/docs/batch-import/python-script/)

5.Using BigML API; (https://bigml.com/)

6.Pandas+scikit+matplotlib+IPython Notebook; (http://nbviewer.ipython.org/url/www.onewinner.me/en/devoxxML.ipynb)

7.Implementing a highly scalable prediction; (http://www.slideshare.net/SpringCentral/implementing-a-highly-scalable-stock-prediction-system-with-r-apache-geode-and-spring-xd)
 (https://github.com/Pivotal-Open-Source-Hub/StockInference-Spark)
 
 ## References
 
TensorFlow Tutorial for Time Series Prediction: https://github.com/tgjeon/TensorFlow-Tutorials-for-Time-Series

## papers

https://www.datascience.us/predicting-success-in-lottery-with-deep-learning/

## Commercial support and training

Commercial support and training is available from smartkit@msn.com.

##
