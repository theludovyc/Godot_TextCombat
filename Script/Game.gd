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
	addText("Un "+mob.name+" apparait.")

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

func todo():
	match state:
		0:
			addLine()
			apparation()
			state=1
		1:
			addLine()
			checkIni()
			state=2
		2:
			addLine()
			if !heroTurn:
				mobAttack()
				heroTurn=true
			else:
				heroAttack()
				heroTurn=false

			if mob.pv<=0:
				state=4
			elif hero.pv<=0:
				state=6
			elif mob_doAttack and hero_doAttack:
				state=3
		3:
			addLine()
			mob_doAttack=false
			hero_doAttack=false
			addText("--- Nouveau tour")
			state=2
		4:
			addLine()
			addText(mob.name+" est mort.")
			state=5
		5:
			addLine()
			mob_doAttack=false
			hero_doAttack=false
			addText("--- Nouveau monstre")
			state=0
		6:
			addLine()
			addText(hero.name+" est mort.")
			state=7
		7:
			addLine()
			addText("Fin de la partie, merci d'avoir jouer!")

func _ready():
	randomize()

	labels=[$Label10, $Label9, $Label8, $Label7, $Label6, $Label5, $Label4, $Label3, $Label2, $Label]

	apparation()
	state=1

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	if Input.is_action_just_pressed("ui_accept"):
		todo()
	pass
