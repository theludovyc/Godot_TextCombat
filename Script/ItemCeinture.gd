extends "ItemEquipe.gd"

func _init(i, i1).(i, i1, "Ceinture", false):
	pass

func use(e):
	e.setForce(item_var)

func checkCarac(e):
	return item_var-e.fr