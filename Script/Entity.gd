var name=""

#point de vie
var pv=0
var pvMax=0

#armure
var arm=0

#capacite de combat
var cc=0.5

#degat
var degMin=1
var degMax=1

#initiative
var ini=0

func _init(s, i, i2):
	name=s
	pvMax=i
	pv=i
	ini=i2

func name():
	var s=name+"("+str(pv)
	if arm>0:
		s+=", "+str(arm)+")"
		return s
	s+=")"
	return s

func setToPvMax():
	pv=pvMax

func addPv(i):
	pv+=i
	if pv>pvMax:
		pv=pvMax

func remPv(i):
	if arm>0:
		if i>arm:
			i-=arm
			pv-=i
			return i
		return 0
	
	pv-=i
	return i

func testAttack():
	if randf()<=cc:
		return true
	return false

func attack():
	return Helper.rand_between(degMin, degMax)