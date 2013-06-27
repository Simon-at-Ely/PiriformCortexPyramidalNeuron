import matplotlib.pyplot as plt
from math import exp

def func(x):
    y = 0
    if abs(x +0.048) < 1e-4:
        '''
        based on, from NEURON...

        FUNCTION vtrap(VminV0, B) {
            if (fabs(VminV0/B) < 1e-6) {
            vtrap = (1 + VminV0/B/2)
        }else{
            vtrap = (VminV0 / B) /(1 - exp((-1 *VminV0)/B))
            }
        }

        '''
        #y = 1.0 / (91e3*(x + 0.048)/(1.0 - (exp ((-0.048 - x)/0.005))) + -62e3 * (x + 0.048)/(1.0 - (exp ((x + 0.048)/0.005))))
        #y = 1.0 / (91e3*0.005* ( ( x + 0.048)/0.005 )/(1.0 - (exp((-0.048 - x)/0.005))) + -62e3 * 0.005 * ( (x + 0.048)/0.005 )/(1.0 - (exp((x + 0.048)/0.005))))
        
        #vtrap1 = ( ( x + 0.048)/0.005 )/(1.0 - (exp((-0.048 - x)/0.005)))
        vtrap1 = (1 + 2*( x + 0.048)/0.005 )
        #vtrap2 = ( ( x + 0.048)/-0.005 )/(1.0 - (exp((-0.048 - x)/-0.005)))
        vtrap2 = (1 + 2*( x + 0.048)/-0.005 )
        
        y = 1.0 / (91e3*0.005* vtrap1 + -62e3 * -0.005 * vtrap2)
    else:
	    y = 1.0 / (91e3*(x + 0.048)/(1.0 - (exp ((-0.048 - x)/0.005))) + -62e3 * (x + 0.048)/(1.0 - (exp ((x + 0.048)/0.005))))
    return y
	
xmin = -0.1
xmax = 0.1
num = 3000
xs = []
ys = []

for i in range(num+1):
    x = xmin + (xmax-xmin)*i/num
    y = func(x)
    print "x = %f, y = %f"%(x, y)
    xs.append(x)
    ys.append(y)
    
lines = plt.plot(xs, ys, '-o')

plt.ylabel('y')
plt.xlabel('x')


plt.show()
