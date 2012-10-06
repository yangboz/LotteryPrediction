import random
from scipy import *
#from pylab import *
import pylab as pylab
#variables
redBalls=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]
blueBalls=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
#test code
#print( random.random() )
for x in range(0,7):#NUM_OF_RED=6
    choice_num_red = random.choice( redBalls )
    print( choice_num_red )
    redBalls.remove(choice_num_red)
for y in range(0,1):#NUM_OF_BLUE=1
    choice_num_blue = random.choice( blueBalls )
    print( choice_num_blue )
#scipy test code
a = zeros(100)
a[:100] = 1
print(a)
b = fft(a)
print(b)
#matplotlib test 
print(pylab.plot(abs(b)))
#show()