var name=""

#point de vie
var pv=0
var pvMax=0

#capacite de combat
var cc=0.0

#capacite de tir
var ct=0.0

#force
var fr=0

#agilite
var ag=0

#intel
var it=0

#initiative
var ini=0

#armure
var arm=0

func _init(s, i, f, i1, i2):
	name=s
	pvMax=i
	pv=i
	cc=f
	fr=i1
	ini=i2

func testAttack():
	if randf()<cc:
		return true
	return false

func setToPvMax():
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

func name():
	var s=name+"("+str(pv)
	if arm>0:
		s+=", "+str(arm)+")"
		return s
	s+=")"
	return s