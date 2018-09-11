extends "Item.gd"

var carac=0

func _init(i, s, b).(s, b):
	equip=true
	carac=Helper.rand_between(1, i)

func checkCarac(e):
	pass

func name(e):
	var i=checkCarac(e)
	if i>0:
		return name+"(+"+str(i)+")"
	return name+"("+str(i)+")"