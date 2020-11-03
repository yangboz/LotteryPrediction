# Using graph_objects
import plotly.graph_objects as go

import pandas as pd
df = pd.read_csv('https://raw.githubusercontent.com/yangboz/LotteryPrediction/master/lottery-data/red_bule_balls_2003.csv')
print(df)
#fig = go.Figure([go.Scatter(x=df['Date'], y=df['AAPL.High'])])
#fig.show()
