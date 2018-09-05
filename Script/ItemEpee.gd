extends "Item.gd"

var degMin=0
var degMax=0

func _init(i).("Epee", false):
	equip=true
	degMax=Helper.rand_between(1, i)
	if degMax==1:
		degMin=1
	else:
		degMin=Helper.rand_between(1, degMax)

func use(e):
	e.setDegMinMax(degMin, degMax)

func name(e):
	var i=degMin-e.degMin
	var i1=degMax-e.degMax

	var s=name+"("

	if i>0:
		s+="+"

	s+=str(i)+", "

	if i1>0:
		s+="+"

	return s+str(i1)+")"