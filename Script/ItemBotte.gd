extends "ItemEquipe.gd"

func _init(i, i1).(i, i1, "Botte", false):
	pass

func use(e):
	e.setAg(item_var)

func checkCarac(e):
	return item_var-e.ag