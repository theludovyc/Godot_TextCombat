extends "ItemEquipe.gd"

func _init(i).(i, "Armure", false):
	item_var/=2
	pass

func use(e):
	e.arm=item_var

func checkCarac(e):
	return item_var-e.arm