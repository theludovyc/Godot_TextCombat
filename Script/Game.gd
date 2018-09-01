extends Node

var Helper=preload("Helper.gd")

var Entity=preload("Entity.gd")
var Gobelin=preload("Gobelin.gd")

var PotionDeVie=preload("ItemPotionVie.gd")

var Armure=preload("ItemArmure.gd")

var hero=Entity.new("Héro", 10, 0.65, 3, 4)
var mob

var labels
var labels_index=0

var state=0

var mob_doAttack=false
var hero_doAttack=false

var heroTurn=false

var hero_press=false
var hero_key0=false
var hero_key1=false
var hero_key2=false
var hero_key3=false

var items
var treasure

func addLine():
	for i in range(labels.size()-1, 0, -1):
		labels[i].text=labels[i-1].text
	labels[0].text=""

func addText(s):
	labels[0].text+=s

func apparation():
	mob=Gobelin.new()
	addText("Un "+mob.name+" apparait !")

func writeDamage(i):
      	addText(" inflige "+str(i)+" dégat(s).")

func checkIni():
	if hero.ini<mob.ini:
		addText(hero.name())
		heroTurn=true
	else:
		addText(mob.name())
		heroTurn=false
	addText(" attaque en premier.")

func mobAttack():
	addText(mob.name())
	if mob.testAttack():
		writeDamage(hero.remPv(mob.fr))
	else:
		addText(" rate son attaque.")
	mob_doAttack=true

func heroAttack():
	addText(hero.name())
	if hero.testAttack():
		writeDamage(mob.remPv(hero.fr))
	else:
		addText(" rate son attaque.")
	hero_doAttack=true

func aide_addText(s):
	$Label11.text+=s

func aide_setText(s):
	$Label11.text=s

func setKeys(b0, b1, b2, b3):
	hero_key0=b0
	hero_key1=b1
	hero_key2=b2
	hero_key3=b3

func newTreasure():
	treasure=items[Helper.rand_between(0, items.size()-1)].new()

func todo():
	match state:
		0:
			addLine()
			addText("--- "+hero.name()+" ouvre une porte.")
			state+=1
		1:
			addLine()
			apparation()
			state+=1
		2:
			addLine()
			checkIni()
			state+=1
		3:
			addLine()
			if !heroTurn:
				mobAttack()
				heroTurn=true
				aide_setText("A. Atk++ Z. Atk+Esq E. Atk+Prd")
				hero_press=true
				setKeys(true, true, true, false)
			else:
				heroAttack()
				heroTurn=false

			if mob.pv<=0:
				state+=1
			elif hero.pv<=0:
				state+=2
			elif mob_doAttack and hero_doAttack:
				state+=3
		4:
			addLine()
			addText(mob.name+" est mort.")
			state+=3
		5:
			addLine()
			addText(hero.name+" est mort.")
			state+=3
		6:
			addLine()
			mob_doAttack=false
			hero_doAttack=false
			addText("- Nouveau tour")
			state-=3
		7:
			addLine()
			addText("-- "+hero.name+" a trouvé un trésor.")
			state+=2
		8:
			addLine()
			addText("Fin de la partie, merci d'avoir jouer !")
		9:
			addLine()
			newTreasure()

			addText("C'est ")

			if treasure.genre:
				addText("un ")
			else:
				addText("une ")

			addText(treasure.name()+" !")

			if treasure.equip:
				aide_setText("A. Equiper ")
			else:
				aide_setText("A. Utiliser ")

			aide_addText("Z. Laisser")

			hero_press=true
			setKeys(true, true, false, false)

			state+=1
		10:
			if !hero_key0:
				addLine()
				treasure.use(hero)

				addText(hero.name)

				if treasure.equip:
					addText(" equipe ")
				else:
					addText(" utilise ")

				addText(treasure.name()+".")

				treasure=null
			elif !hero_key1:
				addLine()
				addText(hero.name+" continu son chemin.")

			mob_doAttack=false
			hero_doAttack=false
			state=0

func _ready():
	randomize()

	items=[PotionDeVie, Armure]

	labels=[$Label10, $Label9, $Label8, $Label7, $Label6, $Label5, $Label4, $Label3, $Label2, $Label]

	addText("--- "+hero.name()+" ouvre une porte.")
	state=1

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	if !hero_press and Input.is_action_just_pressed("ui_accept"):
		todo()
	else:
		if hero_key0 and Input.is_action_just_pressed("MyKey_0"):
			hero_key0=false
			todo()
			aide_setText("")
			hero_press=false
		elif hero_key1 and Input.is_action_just_pressed("MyKey_1"):
			hero_key1=false
			todo()
			aide_setText("")
			hero_press=false
	pass
