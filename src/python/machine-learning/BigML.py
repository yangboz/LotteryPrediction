#@see: http://bigml.readthedocs.org/en/latest/#local-predictions
from bigml.api import BigML
api = BigML('smarkit',"37b903bf765414b5e1c3164061cee5fa57e7e6ad",storage='./storage')

source = api.create_source('./data/red_bule_balls_2003.csv')
api.pprint(api.get_fields(source))
dataset = api.create_dataset(source)
model = api.create_model(dataset)
prediction = api.create_prediction(model, {'red':[1,2,3,4,5,6],'blue':7})
#prediction
api.pprint(prediction)