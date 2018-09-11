extends "ItemEquipe.gd"

func _init(i).(i, "Botte", false):
	pass

func use(e):
	e.setAg(carac)

func checkCarac(e):
	return carac-e.ag