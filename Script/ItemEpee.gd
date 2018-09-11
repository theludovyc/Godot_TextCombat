extends "Item.gd"

var degMin=0

func _init(i, i1).(i, i1, "Epee", false):
	equip=true

	if item_var==1:
		degMin=1
	else:
		degMin=Helper.rand_between(i, item_var)

func use(e):
	e.setDegMinMax(degMin, item_var)

func name(e):
	var j=degMin-e.degMin
	var j1=item_var-e.degMax

	var s=name+"("

	if j>0:
		s+="+"

	s+=str(j)+", "

	if j1>0:
		s+="+"

	return s+str(j1)+")"