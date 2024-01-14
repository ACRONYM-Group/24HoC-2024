extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	
	for i in range(50):
		var location = Vector2i(rng.randi_range(-2500, 2500), rng.randi_range(-2500,2500))
		add_child(generate_asteroid(location))

func generate_asteroid(location: Vector2i):
	var asteroid_script = load("res://Asteroid.gd")
	
	var tile_map = TileMap.new()
	
	tile_map.tile_set = load("res://Scene.tscn::TileSet_r887t")
	tile_map.add_layer(-1)
	tile_map.name = "TileMap"
	
	tile_map.set_script(asteroid_script)
	
	
	tile_map.transform = Transform2D.IDENTITY.translated(location)
	
	return tile_map

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
