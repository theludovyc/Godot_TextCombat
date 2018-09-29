extends Node

var EntityPlayer=preload("EntityPlayer.gd")
var Gobelin=preload("Gobelin.gd")
var Boss=preload("EntityBoss.gd")

var items=[preload("ItemPotionVie.gd"), 
preload("ItemArmure.gd"),
preload("ItemEpee.gd"),
preload("ItemCeinture.gd"),
preload("ItemBotte.gd")]

var hero=EntityPlayer.new("Héro")
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

var treasure

var lvl=1

var hero_def=false

var hero_restore_ed=false
var mob_restore_ed=false

func addLine():
	for i in range(labels.size()-1, 0, -1):
		labels[i].text=labels[i-1].text
	labels[0].text=""

func addText(s):
	labels[0].text+=s

func apparation():
	if(lvl%10==0):
		mob=Boss.new(lvl)
	else:
		mob=Gobelin.new(lvl)

	if mob.arm>=hero.degMax:
		mob.arm=hero.degMax-1

	addText("Un "+mob.name+" apparait !")

func writeDamage(i):
	addText(" inflige "+str(i)+" dégat(s).")

func checkIni():
	if hero.ini<mob.ini:
		addText(hero.name())
		heroTurn=true
		aide_setText("A. Def Z. Atk++ E. Atk")
		hero_press=true
		setKeys(true, true, true, false)
	else:
		addText(mob.name())
		heroTurn=false
	addText(" attaque en premier.")

func activeDef():
	hero.cc+=0.1
	hero_def=true

func disableDef():
	hero.cc-=0.1
	hero_def=false

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
	var id=0

	if lvl%10!=0:
		id=Helper.rand_between(0, items.size()-1)

	treasure=items[id].new(lvl)

func todo():
	match state:
		0:
			addLine()

			hero.pvMax+=1

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

				if mob.testEd():
					mob.remEd()

					if mob.testAttack():
						addText(mob.name()+" attaque, ")

						var b=true

						if hero.testEd() and hero.testAttack():
							hero.remEd()
							addText("mais "+hero.name+" se défend !")
							b=false

						if hero_def:
							disableDef()
						
						if b:
							addText("et ")
							writeDamage(hero.remPv( mob.attack() ))

							if hero.pv<1:
								state+=2
								return
					else:
						if hero_def:
							disableDef()

						addText(mob.name()+" rate son attaque.")
				else:
					if hero_def:
						disableDef()

					addText(mob.name+" semble fatigué.")
					mob_restore_ed=true

				if !hero.testEd():
					hero.setToEdMax()

				heroTurn=true
				aide_setText("A. Def Z. Atk++ E. Atk")
				hero_press=true
				setKeys(true, true, true, false)
			else:
				hero_doAttack=true
				heroTurn=false

				if hero.testEd():
					hero.remEd()

					if !hero_key0:
						activeDef()
						addText(hero.name+" prépare sa défense.")
					else:
						if hero.testAttack():
							var damage=hero.attack()

							if hero.testEd() and !hero_key1:
								hero.remEd()
								damage*=2

							addText(hero.name())
							writeDamage(mob.remPv( damage ))

							if mob.pv<=0:
								state+=1
								return
						else:
							addText(hero.name()+" rate son attaque.")
				else:
					addText(hero.name()+ " semble fatigué.")

				if mob_restore_ed:
					mob.setToEdMax()
					mob_restore_ed=false;

			if mob_doAttack and hero_doAttack:
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
			addText("-- "+hero.name()+" a trouvé un trésor.")
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

			addText(treasure.name(hero)+" !")

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
