#!/usr/bin/python
from __future__ import print_function
try:
	xrange
except NameError:
	xrange=range
from random import choice,randrange
#M,N=1000,10#small
M,N=10000,100#medium
#M,N=100000,1000#large
a=[(randrange(0,M),randrange(0,N),("get %s "+"".join(choice("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~").replace("%","%%")for x in xrange(10))if randrange(0,M/N)else"up %s "+str(randrange(0,10*M/N)))%choice(("China","UnitedStates","India","Japan","Brazil","Russia","Germany","France","UnitedKingdom","Nigeria","Indonesia","Mexico","Korea,South","Italy","Turkey","Vietnam","Spain","Philippines","Egypt","Canada","Poland","Argentina","Colombia","Malaysia","Australia","Pakistan","Taiwan","Iran","Morocco","Thailand","Netherlands","Ukraine","SaudiArabia","Kenya","Venezuela","Peru","SouthAfrica","Romania","Chile","Uzbekistan","Sweden","Belgium","Bangladesh","Kazakhstan","CzechRepublic","Switzerland","Austria","Sudan","Portugal","Hungary","Greece","Tanzania","HongKong","Israel","Algeria","Syria","Denmark","Ecuador","Finland","Azerbaijan","Norway","Uganda","Tunisia","Slovakia","Singapore","Belarus","NewZealand","Bulgaria","UnitedArabEmirates","Yemen","Ireland","DominicanRepublic","Ghana","SriLanka","Croatia","Serbia","Bolivia","Nepal","Angola","Cuba","BosniaandHerzegovina","PalestinianAuthority","Lithuania","Jordan","Senegal","Lebanon","Oman","CostaRica","Kuwait","Zimbabwe","PuertoRico","Uruguay","Georgia","Guatemala","Qatar","Latvia","Zambia","Paraguay","Iraq","Afghanistan","Panama","Albania","Slovenia")))for _ in xrange(M)]
a.sort()
for x in a:
	print(x[0],x[2])
