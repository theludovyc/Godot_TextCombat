extends "Entity.gd"

func _init(i).("Monstre"):
	pv=i
	pvMax=i

	arm=Helper.rand_between(i/3, i/2)

	cc=Helper.rand_between(25, 75)/100.0

	degMax=i

	if i>3:
		degMin=degMax-3
		return

	degMin=1
	pass