extends "ItemEquipe.gd"

func _init(i).(i, "Armure", false):
	pass

func use(e):
	e.arm=carac

func checkCarac(e):
	return carac-e.arm