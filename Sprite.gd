extends Sprite

var PerlinNoise=preload("PerlinNoise.gd")

const MapWidth=128
const Res=10.0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	randomize()

	var perlin=PerlinNoise.new()

	var img=Image.new()
	img.create(MapWidth, MapWidth, false, Image.FORMAT_RGB8)
	img.lock()

	for y in range(img.get_height()):
		for x in range(img.get_width()):
			var noise=(perlin.noise(x, y, Res)+1 )*0.5
			img.set_pixel( x, y, Color(noise, noise, noise) )

	var imgTex=ImageTexture.new()
	imgTex.create_from_image(img, 1)

	set_texture(imgTex)

	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
