extends Node

static func rand_between(a, b):
	a=int(a)
	b=int(b)

	if a==b:
		return a

	return randi()%(b+1-a)+a

static func rand_between_param(a, b, p):
	var r=randf()

	var i_last=1.0-p

	if r>=i_last:
		return b
	
	var ni=b-a

	if ni==1:
		return a

	var i=i_last/(ni-1)

	for j in range(0, ni-2):
		if r<i*(j+1):
			return a+j

static func vec2_compar(vec, a, b):
	if vec.x==a and vec.y==b:
		return true
	return false