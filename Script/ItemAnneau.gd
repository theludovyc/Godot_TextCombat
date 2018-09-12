extends "ItemEquipe.gd"

func _init(i).(i, "Anneau", true):
	pass

func use(e):
	e.ch=item_var

func checkCarac(e):
	return item_var-e.ch