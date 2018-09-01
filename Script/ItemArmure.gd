extends "Item.gd"

var arm=0

func _init().("Armure", false):
	equip=true
	arm=1
	pass

func use(e):
	e.arm=arm

func unuse(e):
	e.arm=0

func name():
	return name+"("+str(arm)+")"