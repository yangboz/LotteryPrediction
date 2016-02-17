"""
http://tempo-db.com/api/write-series/#write-series-by-key
"""

import datetime
import random
from tempodb import Client, DataPoint

# Modify these with your credentials found at: http://tempo-db.com/manage/
API_KEY = '680d1adbbb0c42a398b5846c8e1517dd'
API_SECRET = 'f2db65d178634a36b4c25467f8bc2099'
SERIES_KEY = 'your-custom-key'

client = Client(API_KEY, API_SECRET)

date = datetime.datetime(2012, 1, 1)

for day in range(1, 10):
    # print out the current day we are sending data for
    print date

    data = []
    # 1440 minutes in one day
    for min in range (1, 1441):
        data.append(DataPoint(date, random.random() * 50.0))
        date = date + datetime.timedelta(minutes=1)

    client.write_key(SERIES_KEY, data)