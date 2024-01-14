extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	
	for i in range(25):
		var location = Vector2i(rng.randi_range(-2500, 2500), rng.randi_range(-2500,2500))
		add_child(generate_asteroid(location))

func generate_asteroid(location: Vector2i):
	var asteroid_script = load("res://Asteroid.gd")
	
	var asteroid = RigidBody2D.new()
	var tile_map = TileMap.new()
	
	tile_map.tile_set = load("res://Scene.tscn::TileSet_yp6bf")
	tile_map.add_layer(-1)
	tile_map.name = "TileMap"
	
	var collider = CollisionPolygon2D.new()
	collider.name = "Collider"
	
	asteroid.set_script(asteroid_script)
	
	asteroid.add_child(tile_map)
	asteroid.add_child(collider)
	
	asteroid.transform = Transform2D.IDENTITY.translated(location)
	
	return asteroid

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
