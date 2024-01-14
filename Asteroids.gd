extends Node

@export var list_of_asteroids = []
@export var generated_area = 2500

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	
	for i in range(50):
		var location = Vector2i(rng.randi_range(-generated_area, generated_area), rng.randi_range(-generated_area,generated_area))
		var new_asteroid = generate_asteroid(location)
		list_of_asteroids.append(new_asteroid)
		add_child(new_asteroid)

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
