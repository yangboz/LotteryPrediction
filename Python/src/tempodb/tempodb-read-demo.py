"""
http://tempo-db.com/api/read-series/#read-series-by-key
"""

import datetime
from tempodb import Client

# Modify these with your settings found at: http://tempo-db.com/manage/
API_KEY = '680d1adbbb0c42a398b5846c8e1517dd'
API_SECRET = 'f2db65d178634a36b4c25467f8bc2099'
SERIES_KEY = 'your-custom-key'

client = Client(API_KEY, API_SECRET)

start = datetime.date(2012, 1, 1)
end = start + datetime.timedelta(days=1)

data = client.read_key(SERIES_KEY, start, end)

for datapoint in data.data:
    print datapoint