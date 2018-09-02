extends "Item.gd"

var pv=0

func _init(i).("Potion de Vie", false):
	pv=Helper.rand_between(1, 9)
	pass

func use(e):
	e.addPv(pv)

func name():
	return name+"("+str(pv)+")"