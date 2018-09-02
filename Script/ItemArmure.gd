extends "Item.gd"

var arm=0

func _init(i).("Armure", false):
	equip=true
	arm=Helper.rand_between(1, i)
	pass

func use(e):
	e.arm=arm

func name(i):
	i=arm-i
	if i>0:
		return name+"(+"+str(i)+")"
	return name+"("+str(i)+")"