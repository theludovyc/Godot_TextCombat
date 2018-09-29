extends "Entity.gd"

func _init(i).("Gobelin", 2, 2):
	cc=int(i/10)/10.0+0.1

	ed=2
	edMax=2

	arm=i-1;

	degMax=i
	if i>3:
		degMin=degMax-3
		return

	degMin=1
	pass