var name=""

#point de vie
var pv=0
var pvMax=0

#armure
var arm=0
var armMax=0

#capacite de combat
var cc=0.5

#degat
var degMin=1
var degMax=1

#initiative
var ini=0

#endurance
var ed=0
var edMax=0

func _init(s):
	name=s

func name():
	var s=name+"("+str(pv)

	if arm>0:
		s+=", "+str(arm)
		
	return s+")"

func setToPvMax():
	pv=pvMax

func addPv(i):
	pv+=i
	if pv>pvMax:
		pv=pvMax

func setToArmMax():
	arm=armMax

func remPv(i):
	if arm>0:
		if i==arm:
			arm=0
			return 0
		else:
			if i>arm:
				i-=arm
				pv-=i
				arm=0
				return i
			
			arm-=i
			return 0
	
	pv-=i
	return i

func getDifDegMaxMin():
	return degMax-degMin

func setToEdMax():
	ed=edMax

func testEd():
	if ed>0:
		return true
	return false

func testAttack():
	if randf()<=cc:
		return true
	return false

func remEd():
	if ed>0:
		ed-=1

func attack():
	return Helper.rand_between(degMin, degMax)