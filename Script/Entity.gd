var name=""

#point de vie
var pv=0

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

func _init(s, i, f, i1, i2):
	name=s
	pv=i
	cc=f
	fr=i1
	ini=i2

func testAttack():
	if randf()<cc:
		return true
	return false