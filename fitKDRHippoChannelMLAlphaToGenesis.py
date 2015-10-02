import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


def alpha(v):
	if (abs(v+0.0392)<0.0001):
		a =  79.4679 

	else:
		a =  ((-1.0 * 627.2) + (-1.0 * 16000 * v))/(-1.0 + (np.exp(-1.0 * (v + 0.0392)/ 0.005)))
	return a



def alphaExpLinear(x,p1,p2,p3):
	a = p1*(((x-p3)/p2)/(1-np.exp((x-p3)/p2)))
	return a



if __name__ == "__main__":
	x = np.linspace(-0.1,0.1,3000)
	a = np.zeros((3000,1))

	for i,v in enumerate(x):
		a[i] = alpha(v)





	# fit the ExpLinear to the alpha from GENESIS
	popt, pcov = curve_fit(alphaExpLinear, x, a[:,0],p0=(1.0,-0.01,-0.04))
	print popt
	
	alpha_fit = alphaExpLinear(x,popt[0],popt[1],popt[2])
	
	# compare fit and original function
	'''res = np.zeros((3000,1))
	for i,aa in enumerate(a):
		res[i] = abs(aa-alpha_fit[i])
	rmax = np.max(res)
	rmaxi = np.argmax(res)
	step = rmaxi*(0.2/3000)-0.1
	print rmax
	print rmaxi
	print step
	
	a1 = alpha(step)
	a2 = alphaExpLinear(step,popt[0],popt[1],popt[2])
	print a1,a2
	'''
	plt.figure()
	#plt.plot(x,a,'r',label='Original')
	#plt.plot(x,alpha_fit,'k',label='Fitted LinExp')
	#plt.plot(x,res,'r')
	plt.plot(x[900:1000],a[900:1000],'r',label='Original')
	plt.plot(x[900:1000],alpha_fit[900:1000],'k',label='Fitted LinExp')
	plt.legend()
	plt.show()
