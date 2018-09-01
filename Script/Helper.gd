static func rand_between(a, b):
	return randi()%(b+1-a)+a

static func vec2_compar(vec, a, b):
	if vec.x==a and vec.y==b:
		return true
	return false