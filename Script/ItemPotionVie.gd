extends "Item.gd"

func _init().("Potion de Vie", false):
	pass

func use(e):
	e.setToPvMax()