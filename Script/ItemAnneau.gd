extends "ItemEquipe.gd"

func _init(i, i1).(i, i1, "Anneau", true):
	pass

func use(e):
	e.ch=item_var

func checkCarac(e):
	return item_var-e.ch