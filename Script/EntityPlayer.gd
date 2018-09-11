extends "Entity.gd"

#force
var fr=1

#agilite
var ag=1

#intel
var it=1

var cc_bonus=0.0

func reset_cc_bonus():
	cc_bonus=(1-cc)*(ag/100.0)

func _init(s).(s, 10, 5):
	reset_cc_bonus()
	pass

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

func resetDegMinMax():
	var np=degMax-degMin

	if np<2:
		return

	var i=100.0/np

	for j in range(1, np):
		if fr>=100-j*i:
			degMin=degMax-j
			return

func setForce(a):
	fr=a

	if fr==100:
		return

	resetDegMinMax()

func addForce(a):
	fr+=a

	if fr>100:
		fr=100

	if fr==100:
		return

	resetDegMinMax()

func remForce(a):
	fr-=a

	if fr<1:
		fr=1

	resetDegMinMax()

func setAg(a):
	ag=a

	if ag==100:
		return

	reset_cc_bonus()

func testAttack():
	if ag==100:
		return true

	var i=cc+cc_bonus

	var f=randf()

	print(f, " / ", i)

	if i>=1 or f<=i:
		return true
	return false

func attack():
	if fr==100:
		return degMax
	return Helper.rand_between(degMin, degMax)