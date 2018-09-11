extends "ItemEquipe.gd"

func _init(i, i1).(i, i1, "Armure", false):
	pass

func use(e):
	e.arm=item_var

func checkCarac(e):
	return item_var-e.arm