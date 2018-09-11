extends "ItemEquipe.gd"

func _init(i).(i, "Ceinture", false):
	pass

func use(e):
	e.setForce(carac)

func checkCarac(e):
	return carac-e.fr