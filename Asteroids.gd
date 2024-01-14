extends Node

@export var list_of_asteroids = []
@export var generated_area = 1000
@export var last_generation_position = Vector2(0, 0)

var keep_out_zones = [Vector3(0, 0, 1000)]

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_ring_tile(last_generation_position)
	
		
func generate_ring_tile(player_position):
	keep_out_zones = [Vector3(0, 0, 1000)]
	var asteroid_count = 0
	remove_all_asteroids()
	print(list_of_asteroids.size())
	var tile_x = int((player_position.x - generated_area/2) / (generated_area*2))
	var tile_y = int((player_position.y - generated_area/2) / (generated_area*2))
	var rng = RandomNumberGenerator.new()
	
	for tx in range(-1, 2):
		for ty in range(-1, 2):
			asteroid_count = 0
			rng.state = 0
			rng.seed = 42069 + (tile_x + tx) + ((tile_y + ty)*10000)
			var tile_x_offset = ((tile_x + tx) * (generated_area*2))
			var tile_y_offset = ((tile_y + ty) * (generated_area*2))
			for i in range(5):
				var location = Vector2i(rng.randi_range(-generated_area, generated_area) + tile_x_offset, rng.randi_range(-generated_area,generated_area) + tile_y_offset)
				var keep_out = false
				for x in keep_out_zones:
					if sqrt(pow(location.x - x.x, 2)+pow(location.y - x.y, 2)) < x.z:
						keep_out = true
						
				if keep_out == false:
					var new_asteroid = generate_asteroid(location, rng.seed+(asteroid_count*1100))
					list_of_asteroids.append(new_asteroid)
					add_child(new_asteroid)
					asteroid_count += 1
					
					keep_out_zones.append(Vector3(location.x, location.y, 300))
	
	last_generation_position = player_position
		
func remove_all_asteroids():
	for x in list_of_asteroids:
		remove_child(x)
		
	list_of_asteroids = []
		

func generate_asteroid(location: Vector2i, rng_seed):
	var asteroid_script = load("res://Asteroid.gd")
	
	var tile_map = TileMap.new()
	
	tile_map.tile_set = load("res://Scene.tscn::TileSet_r887t")
	tile_map.add_layer(-1)
	tile_map.name = "TileMap"
	
	tile_map.set_script(asteroid_script)
	
	
	tile_map.transform = Transform2D.IDENTITY.translated(location)
	
	tile_map.generate_random(rng_seed)
	
	return tile_map

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
