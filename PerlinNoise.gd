var perms

var grads

func _init():
	perms=PoolByteArray()

	#tableau 512
	for i in range(256):
		perms.append(i)
		perms.append(i)

	#melange
	for i in range(255, 1, -1):
		var j = Helper.rand_between(0, i)
		var k = perms[i]
		perms[i]=perms[j]
		perms[j]=k

	grads=PoolVector2Array()

	grads.append( Vector2(1, 0) )
	grads.append( Vector2(-1, 0) )
	grads.append( Vector2(0, 1) )
	grads.append( Vector2(0, -1) )
	grads.append( Vector2(1, 1).normalized() )
	grads.append( Vector2(-1, 1).normalized() )
	grads.append( Vector2(1, -1).normalized() )
	grads.append( Vector2(-1, -1).normalized() )

func noise(x, y, res):
	x/=res
	y/=res

	var x0=int(x)
	var y0=int(y)

	var ii=clamp(x0, 0, 255)
	var jj=clamp(y0, 0, 255)

	var gi0 = perms[ ii+perms[jj] ]%8
	var gi1 = perms[ ii+1+perms[jj] ]%8
	var gi2 = perms[ ii+perms[jj+1] ]%8
	var gi3 = perms[ ii+1+perms[jj+1] ]%8

	var s=grads[gi0].dot( Vector2( x-x0,y-y0 ) )
	var t=grads[gi1].dot( Vector2( x-(x0+1),y-y0 ) )
	var u=grads[gi2].dot( Vector2( x-x0,y-(y0+1) ) )
	var v=grads[gi3].dot( Vector2( x-(x0+1),y-(y0+1) ) )

	var tmp=x-x0

	var cx=3*tmp*tmp-2*tmp*tmp*tmp

	var li1=s+cx*(t-s)
	var li2=u+cx*(v-u)

	tmp=y-y0

	var cy=3*tmp*tmp-2*tmp*tmp*tmp

	return li1+cy*(li2-li1)