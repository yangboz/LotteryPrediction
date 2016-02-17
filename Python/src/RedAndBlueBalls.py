import pandas
import time
import matplotlib.pyplot as plt
import random
import numpy
#See http://www.red-dove.com/python_logging.html
import logging
logging.basicConfig()
log = logging.getLogger(None)
log.setLevel(logging.DEBUG) #set verbosity to show all messages of severity >= DEBUG
log.info("Starting PandasCSV!")
class UTCFormatter(logging.Formatter):
    converter = time.gmtime # not documented, had to read the module's source code ;-)
#read CSV
#balls = pd.read_csv('../../lottery-data/red_bule_balls_2003.csv')
balls = pandas.read_csv('../../lottery-data/red_bule_balls.csv',sep=';',header=None)
print(balls)
#Dot plot,a very simple way to gain an initial sense of the data set is to create a dot plot.
##Dot plot display
###Blue balls statistics
blue_balls = balls['X7']
print("blue_balls.describe:")
print(blue_balls.describe())
series_blue_balls = pandas.Series(blue_balls)
print("series_blue_balls.value_counts():")
series_blue_balls_value_counts = series_blue_balls.value_counts()
##sort_index
series_blue_balls_value_counts = series_blue_balls_value_counts.sort_index(ascending=True)
print(series_blue_balls_value_counts)
##Dot plot display
dfs_blue_balls_count_values = series_blue_balls_value_counts.values
print("Dot,dfs_blue_balls_count_values:")
print(dfs_blue_balls_count_values)
plt.plot(dfs_blue_balls_count_values,'x',label='Dot plot')
plt.legend()
plt.ylabel('Y-axis,number of blue balls')
plt.xlabel('X-axis,number of duplication')
plt.show()
#Jitter plot
idx_min = min(dfs_blue_balls_count_values)
idx_max = max(dfs_blue_balls_count_values)
idx_len = idx_max-idx_min
print("min:",idx_min,"max:",idx_max)
num_jitter = 0
samplers = random.sample(range(idx_min,idx_max),idx_len)
while num_jitter < 5:
    samplers += random.sample(range(idx_min,idx_max),idx_len)
    num_jitter += 1
##lots of jitter effect
print("samplers:",samplers)
#plt.plot(samplers,'ro',label='Jitter plot')
#plt.ylabel('Y-axis,number of blue balls')
#plt.xlabel('X-axis,number of duplication')
#plt.legend()
#plt.show()
#Histograms and Kernel Density Estimates:
#Scott rule,
#This rule assumes that the data follows a Gaussian distribution;

#Plotting the blue balls appear frequency histograms(x-axis:frequency,y-axis:VIPs)
##@see http://pandas.pydata.org/pandas-docs/dev/basics.html#value-counts-histogramming
num_of_bin = len(series_blue_balls_value_counts)
array_of_ball_names = series_blue_balls_value_counts.keys()
print("Blue ball names:",array_of_ball_names)
list_merged_by_ball_id = []
for x in xrange(0,num_of_bin):
    num_index = x+1.5
    list_merged_by_ball_id += [num_index]*dfs_blue_balls_count_values[x]
print("list_merged_by_ball_id:",list_merged_by_ball_id)  
##Histograms plotting
plt.hist(list_merged_by_ball_id, bins=num_of_bin)
plt.legend()
plt.xlabel('Histograms,number of appear time by blue ball number')
plt.ylabel('Histograms,counter of appear time by blue ball number')
plt.show()
###Gaussian_KDE
from scipy.stats import gaussian_kde
density = gaussian_kde(list_merged_by_ball_id)
xs = numpy.linspace(0,8,200)
density.covariance_factor = lambda : .25
density._compute_covariance()
plt.plot(xs,density(xs))
plt.xlabel('KDE,number of appear time by blue ball number')
plt.ylabel('KDE,counter of appear time by blue ball number')
plt.show()
##CDF(The Cumulative Distribution Function
from scipy.stats import cumfreq
idx_max = max(dfs_blue_balls_count_values)
hi = idx_max
a = numpy.arange(hi) ** 2
#    for nbins in ( 2, 20, 100 ):
for nbins in dfs_blue_balls_count_values:    
    cf = cumfreq(a, nbins)  # bin values, lowerlimit, binsize, extrapoints
    w = hi / nbins
    x = numpy.linspace( w/2, hi - w/2, nbins )  # care
    # print x, cf
    plt.plot( x, cf[0], label=str(nbins) )

plt.legend()
plt.xlabel('CDF,number of appear time by blue ball number')
plt.ylabel('CDF,counter of appear time by blue ball number')
plt.show()

###Optional: Comparing Distributions with Probability Plots and QQ Plots
###Quantile plot of the server data. A quantile plot is a graph of the CDF with the x and y axes interchanged.
###Probability plot for the data set shown,a standard normal distribution:
###@see: http://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.probplot.html
import scipy.stats as stats
prob_measurements = numpy.random.normal(loc = 20, scale = 5, size=num_of_bin)   
stats.probplot(prob_measurements, dist="norm", plot=plt)
plt.show()