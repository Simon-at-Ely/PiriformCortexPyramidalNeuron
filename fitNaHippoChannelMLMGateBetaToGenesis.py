import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


def beta(v):
	if (abs(v+0.0092)<0.0001):
		b =  18688.4

	else:
		b = ((2576 + (280000 * v)) / (-1.0 + (np.exp ((v + 0.0092)/ 0.005))))
	return b



def betaExpLinear(x,p1,p2,p3):
	b = p1*(((x-p3)/p2)/(1-np.exp((x-p3)/p2)))
	return b



if __name__ == "__main__":
	x = np.linspace(-0.1,0.1,3000)
	b = np.zeros((3000,1))

	for i,v in enumerate(x):
		b[i] = beta(v)





	# fit the ExpLinear to the alpha from GENESIS
	popt, pcov = curve_fit(betaExpLinear, x, b[:,0],p0=(1.0,-0.01,-0.04))
	print popt
	
	beta_fit = betaExpLinear(x,popt[0],popt[1],popt[2])
	
	# compare fit and original function
	res = np.zeros((3000,1))
	for i,bb in enumerate(b):
		res[i] = abs(bb-beta_fit[i])
	rmax = np.max(res)
	rmaxi = np.argmax(res)
	step = rmaxi*(0.2/3000)-0.1
	print rmax
	print rmaxi
	print step
	
	b1 = beta(step)
	b2 = betaExpLinear(step,popt[0],popt[1],popt[2])
	print b1,b2

	plt.figure()
	#plt.plot(x,b,'r',label='Original')
	#plt.plot(x,beta_fit,'k',label='Fitted LinExp')
	#plt.plot(x,res,'r')
	plt.plot(x[1300:1400],b[1300:1400],'r',label='Original')
	plt.plot(x[1300:1400],beta_fit[1300:1400],'k',label='Fitted LinExp')
	plt.legend()
	plt.show()
