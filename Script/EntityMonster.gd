extends "Entity.gd"

func _init(i).("Monstre"):
	pv=i
	pvMax=i

	armMax=Helper.rand_between(i*0.25, i*0.75)
	arm=armMax

	cc=Helper.rand_between(25, 75)/100.0

	ini=Helper.rand_between(1,10)

	degMax=i

	if i>3:
		degMin=degMax-3
		return

	degMin=1
	pass