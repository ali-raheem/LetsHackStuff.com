#!/usr/bin/env python

mo = 255.
mi = 1023.

def R(x,mi,mo):
	if(x>mi/2):
		return mo*(2*x/mi-1)
	return 0

def G(x,mi,mo):
	if(x<mi/2):
		return 2*mo*x/mi
	return 2*mo*(1-x/mi)

def B(x,mi,mo):
	if(x<mi/2):
		return mo*(1-2*x/mi)
	return 0

def RGB(i):
	print i,B(i,mi,mo),G(i,mi,mo),R(i,mi,mo)

for y in range(0,int(mi)):
	RGB(y)
