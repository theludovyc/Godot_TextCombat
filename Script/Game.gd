extends Node

var Entity=preload("Entity.gd")
var Gobelin=preload("Gobelin.gd")

var PotionDeVie=preload("ItemPotionVie.gd")
var Armure=preload("ItemArmure.gd")
var Epee=preload("ItemEpee.gd")

var hero=Entity.new("Héro", 10, 5)
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

var lvl=1

var hero_def=false

func addLine():
	for i in range(labels.size()-1, 0, -1):
		labels[i].text=labels[i-1].text
	labels[0].text=""

func addText(s):
	labels[0].text+=s

func apparation():
	mob=Gobelin.new(lvl)
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

func doAttack(e, e1):
	addText(e.name())
	if e.testAttack():
		writeDamage(e1.remPv( e.attack() ))
	else:
		addText(" rate son attaque.")

func doHugeAttack(e, e1):
	addText(e.name())
	if e.testAttack():
		writeDamage(e1.remPv( e.attack()*2 ))
	else:
		addText(" rate son attaque.")

func mobAttack():
	doAttack(mob, hero)
	mob_doAttack=true

func activeDef():
	hero.cc+=0.1
	hero_def=true

func disableDef():
	hero.cc-=0.1
	hero_def=false

func heroAttack():
	addText(hero.name())
	if hero.testAttack():
		var damage=hero.attack()
		if !hero_key2:
			damage*=2
		writeDamage(mob.remPv( damage ))
	else:
		addText(" rate son attaque.")

	if !hero_key1:
		activeDef()
	else:
		disableDef()

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
	treasure=items[Helper.rand_between(0, items.size()-1)].new(lvl)

func todo():
	match state:
		0:
			addLine()
			addText("--- "+hero.name()+" ouvre une porte("+str(lvl)+").")
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
				mob_doAttack=true

				addText(mob.name())
				if mob.testAttack():
					addText(" attaque, ")

					if hero_def and hero.testAttack():
						addText("mais "+hero.name+" se défend !")
						disableDef()
					else:
						addText("et ")
						writeDamage(hero.remPv( mob.attack() ))

						if hero.pv<1:
							state+=2
							return
				else:
					addText(" rate son attaque.")

				heroTurn=true
				aide_setText("A. Atk Z. Atk+Def, E. Atk++")
				hero_press=true
				setKeys(true, true, true, false)
			else:
				heroAttack()
				heroTurn=false

				if mob.pv<=0:
					if hero_def:
						disableDef()
					state+=1
					return

				if hero_def:
					state+=3
					return

			if mob_doAttack and hero_doAttack:
				state+=4
		4:
			addLine()
			addText(mob.name+" est mort.")
			state+=4
		5:
			addLine()
			addText(hero.name+" est mort.")
			state+=4

		6:
			addLine()
			addText(hero.name+" prépare sa défense.")

			if mob_doAttack:
				state+=1
				return
			
			state-=3
		7:
			addLine()
			mob_doAttack=false
			hero_doAttack=false
			addText("- Nouveau tour")
			state-=4
		8:
			addLine()
			addText("-- "+hero.name()+" a trouvé un trésor.")
			state+=2
		9:
			addLine()
			addText("Fin de la partie, merci d'avoir jouer !")
		10:
			addLine()
			newTreasure()

			addText("C'est ")

			if treasure.genre:
				addText("un ")
			else:
				addText("une ")

			addText(treasure.name(hero)+" !")

			if treasure.equip:
				aide_setText("A. Equiper ")
			else:
				aide_setText("A. Utiliser ")

			aide_addText("Z. Laisser")

			hero_press=true
			setKeys(true, true, false, false)

			state+=1
		11:
			if !hero_key0:
				addLine()
				treasure.use(hero)

				addText(hero.name)

				if treasure.equip:
					addText(" s'en equipe.")
				else:
					addText(" l'utilise.")

				treasure=null
			elif !hero_key1:
				addLine()
				addText(hero.name+" continu son chemin.")

			mob_doAttack=false
			hero_doAttack=false
			lvl+=1
			state=0

func _ready():
	randomize()

	items=[PotionDeVie, Armure, Epee]

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
		elif hero_key2 and Input.is_action_just_pressed("MyKey_2"):
			hero_key2=false
			todo()
			aide_setText("")
			hero_press=false
	pass
