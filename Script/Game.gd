extends Node

var Entity=preload("Entity.gd")
var Gobelin=preload("Gobelin.gd")

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

func addLine():
	for i in range(labels.size()-1, 0, -1):
		labels[i].text=labels[i-1].text
	labels[0].text=""

func addText(s):
	labels[0].text+=s

func writeMobName():
	addText(mob.name+"("+str(mob.pv)+")")

func apparation():
	mob=Gobelin.new()
	addText("Un "+mob.name+" apparait !")

func writeHeroName():
	addText(hero.name+"("+str(hero.pv)+")")

func writeDamage(e):
	addText(" inflige "+str(e.fr)+" dégat(s).")

func checkIni():
	if hero.ini<mob.ini:
		writeHeroName()
		heroTurn=true
	else:
		writeMobName()
		heroTurn=false
	addText(" attaque en premier.")

func mobAttack():
	writeMobName()
	if mob.testAttack():
		writeDamage(mob)
		hero.pv-=mob.fr
	else:
		addText(" rate son attaque.")
	mob_doAttack=true

func heroAttack():
	writeHeroName()
	if hero.testAttack():
		writeDamage(hero)
		mob.pv-=hero.fr
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

func todo():
	match state:
		0:
			addLine()
			addText("--- "+hero.name+" ouvre une porte.")
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
			addText("-- "+hero.name+" trouve un trésor.")
			state+=2
		8:
			addLine()
			addText("Fin de la partie, merci d'avoir jouer !")
		9:
			addLine()
			addText("C'est une potion de vie !")

			aide_setText("A. Utiliser Z. Equiper E. Prendre R. Laisser")
			hero_press=true
			setKeys(true, true, true, true)

			state+=1
		10:
			if !hero_key0:
				addLine()
				addText(hero.name+" utilise potion de vie.")

			mob_doAttack=false
			hero_doAttack=false
			state=0

func _ready():
	randomize()

	labels=[$Label10, $Label9, $Label8, $Label7, $Label6, $Label5, $Label4, $Label3, $Label2, $Label]

	addText("--- "+hero.name+" ouvre une porte.")
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
	pass
