import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


def alpha(v):
	if (abs(v-0.048)<0.0001):
		a =  8736 

	else:
		a =  (91000 * (v + 0.048))/ (1.0 - (np.exp ((-1.0 * 0.048 - v)/ 0.005))) 
	return a

def beta(v):
	if (abs(v-0.048)<0.0001):
		b =  0.0013072

	else:
		b = ((-1.0 * 62000) * (v + 0.048))/ (1.0 - (np.exp ((v + 0.048)/ 0.005)))
	return b


def tau(v):
	if (abs(v-0.048)<0.0001):
		t =  0.0013072

	else:
		t = ( 1.0 / (91000 * (v + 0.048)/ (1.0 - (np.exp ((-1.0 * 0.048 - v)/ 0.005)))+(-1.0 * 62000) * (v + 0.048)/ (1.0 - (np.exp ((v + 0.048)/ 0.005)))))
	return t
	

def inf(v):
	i = 1.0 / (1.0 + (np.exp ((-1.0 * 0.043 - v)/ 0.005)))
	return i

def alphaExpLinear(x,p1,p2,p3):
	a = p1*(((x-p3)/p2)/(1-np.exp((x-p3)/p2)))
	return a

def betaExpLinear(x,p1,p2,p3):
	b = p1*(((x-p3)/p2)/(1-np.exp((x-p3)/p2)))
	return b

if __name__ == "__main__":
	x = np.linspace(-0.1,0.1,3000)
	a = np.zeros((3000,1))
	b = np.zeros((3000,1))
	t = np.zeros((3000,1))
	ii = np.zeros((3000,1))

	for i,v in enumerate(x):
		a[i] = alpha(v)
		b[i] = beta(v)
		t[i] = tau(v)
		ii[i] = inf(v)




	# fit the ExpLinear to the alpha from GENESIS
	popt, pcov = curve_fit(alphaExpLinear, x, a[:,0],p0=(1.0,-0.01,-0.04))
	print popt
	
	alpha_fit = alphaExpLinear(x,popt[0],popt[1],popt[2])
	
	# compare fit and original function
	res = np.zeros((3000,1))
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

	tau_fit = 1/(alpha_fit+beta_fit)
	inf_fit = alpha_fit/(alpha_fit+beta_fit)

	plt.figure()
	#plt.plot(x,a,'r',label='Original')
	#plt.plot(x,alpha_fit,'k',label='Fitted LinExp')
	#plt.plot(x,b,'r',label='Original')
	#plt.plot(x,beta_fit,'k',label='Fitted LinExp')
	#plt.plot(x,t,'r',label='Original')
	#plt.plot(x,tau_fit,'k',label='Fitted LinExp')
	plt.plot(x,ii,'r',label='Original')
	plt.plot(x,inf_fit,'k',label='Fitted LinExp')
	#plt.plot(x,res,'r')
	#plt.plot(x[900:1000],a[900:1000],'r',label='Original')
	#plt.plot(x[900:1000],alpha_fit[900:1000],'k',label='Fitted LinExp')
	plt.legend()
	plt.show()
