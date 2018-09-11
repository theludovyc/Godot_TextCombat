extends "Item.gd"

func _init(i, i1).(i, i1, "Potion de Vie", false):
	pass

func use(e):
	e.addPv(item_var)

func name(e):
	return name+"("+str(item_var)+")"