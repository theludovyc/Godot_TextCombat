var name=""

#point de vie
var pv=0
var pvMax=0

#armure
var arm=0

#capacite de combat
var cc=0.5

#capacite de tir
var ct=0.5

#degat
var degMin=1
var degMax=1

#force
var fr=1

#agilite
var ag=1

#intel
var it=1

#chance
var ch=1

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
	if randf()<cc:
		return true
	return false

func setDegMinMax(a, b):
	degMax=b

	if fr==100:
		return

	var np=b-a

	if np<2:
		degMin=a
		return

	var i=100.0/np

	for j in range(1, np):
		if fr>=100-j*i:
			degMin=degMax-j
			return

	degMin=a

func attack():
	if fr==100:
		return degMax
	return Helper.rand_between(degMin, degMax)