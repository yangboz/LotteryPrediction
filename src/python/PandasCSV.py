import pandas as pd
#See http://www.red-dove.com/python_logging.html
import logging
import time
class UTCFormatter(logging.Formatter):
    converter = time.gmtime # not documented, had to read the module's source code ;-)
logging.basicConfig()
log = logging.getLogger(None)
log.setLevel(logging.DEBUG) #set verbosity to show all messages of severity >= DEBUG
fh = logging.FileHandler('some_log_file')
fh.setLevel(logging.DEBUG)
formatter = UTCFormatter('[%(asctime)s] %(message)s', '%d/%b/%Y:%H:%M:%S')
fh.setFormatter(formatter)
log.addHandler(fh)
log.info("Starting PandasCSV!")
#read CSV
#balls = pd.read_csv('../../lottery-data/red_bule_balls_2003.csv')
balls = pd.read_csv('../../lottery-data/red_bule_balls_2003.csv',sep=';',header=None)
print(balls)