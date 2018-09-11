var name=""

var genre=false

var equip=false

var item_var=0

func _init(i, i1, s, b):
	var item_var_min=1

	if i1>5:
		item_var_min=i1-5+5*(i/100.0)

	item_var=Helper.rand_between(item_var_min, i1+3)

	print("item_var_min ", item_var_min, " / i1 ", i1," / item_var ", item_var)

	name=s
	genre=b

func use(e):
	pass

func name(e):
	return name