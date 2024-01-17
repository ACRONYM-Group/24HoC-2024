extends Node

@export var list_of_asteroids = []
@export var generated_area = 1000
@export var last_generation_position = Vector2(0, 0)

var keep_out_zones = [Vector3(0, 0, 1000)]

var asteroid_uid_counter = 0

var persistent_asteroid_data = [{
	"x":-150,
	"y":550,
	"tile_map_data": [[[0, 0], 17], [[0, 1], 17], [[-1, 1], 17], [[0, -1], 17], [[1, -1], 17], [[-1, 2], 17], [[1, 1], 17], [[-2, 1], 0], [[-1, 0], 17], [[-1, -1], 1], [[0, -2], 1], [[1, 0], 1], [[2, -2], 17], [[-1, 3], 2], [[-2, 3], 2], [[-2, 2], 0], [[0, 2], 1], [[2, 1], 2], [[-3, 2], 0], [[-3, 1], 1], [[-2, 0], 2], [[-1, -2], 0], [[0, -3], 2], [[1, -3], 2], [[1, -2], 1], [[2, -1], 0], [[2, -3], 2], [[3, -3], 0], [[3, -2], 2], [[-3, 4], 1], [[-3, 3], 0], [[1, 2], 1], [[2, 2], 1], [[2, 0], 1], [[3, 0], 1], [[-3, 0], 1], [[-2, -1], 1], [[-2, -2], 1], [[-1, -3], 0], [[0, -4], 0], [[1, -4], 2], [[2, -4], 2], [[3, -1], 1], [[3, -4], 0], [[4, -4], 0], [[4, -3], 0], [[-4, 5], 1], [[-4, 4], 2], [[-2, 4], 1], [[-4, 3], 1], [[-4, 2], 1], [[1, 3], 1], [[0, 3], 1], [[2, 3], 1], [[3, 2], 1], [[4, -1], 1], [[-4, 1], 0], [[-4, 0], 0], [[-3, -1], 2], [[-3, -2], 2], [[-2, -3], 0], [[1, -5], 1], [[2, -5], 0], [[3, -5], 0], [[4, -2], 2], [[4, -5], 2], [[5, -3], 1]],
	"tile_x":0,
	"tile_y":0,
	"uid":0
}]
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_ring_tile(last_generation_position)
	
	
		
func load_ring_tile_from_data(tile_x, tile_y):
	var number_of_asteroids_loaded = 0
	for x in persistent_asteroid_data:
		#print(x["tile_x"])
		if x["tile_x"] == tile_x and x["tile_y"] == tile_y:
			#print(persistent_asteroid_data)
			#print("Generating new asteroid at " + str(Vector2(x["x"], x["y"])))
			var asteroid_script = load("res://Asteroid.gd")
			
			var tile_map = TileMap.new()
			
			tile_map.tile_set = load("res://Scene.tscn::TileSet_r887t")
			tile_map.add_layer(-1)
			tile_map.name = "TileMap"
			
			tile_map.set_script(asteroid_script)
			
			
			tile_map.transform = Transform2D.IDENTITY.translated(Vector2(x["x"], x["y"]))
			
			#tile_map.generate_random(rng_seed)
			tile_map.load_tile_map_from_data(x["tile_map_data"])
			
			var new_asteroid = tile_map
			list_of_asteroids.append(new_asteroid)
			
			new_asteroid.uid = x["uid"]
			new_asteroid.tile_x = x["tile_x"]
			new_asteroid.tile_y = x["tile_y"]
			add_child(new_asteroid)
			
			number_of_asteroids_loaded += 1
			
			if asteroid_uid_counter <= x["uid"]:
				asteroid_uid_counter = x["uid"] + 1
	
	return number_of_asteroids_loaded
		
func generate_ring_tile(player_position):
	#print("uid counter: " + str(asteroid_uid_counter))
	#print("Number of persistent asteroids: " + str(persistent_asteroid_data.size()))
	keep_out_zones = [Vector3(0, 0, 1000)]
	var asteroid_count = 0
	unload_all_asteroids()
	var tile_x = int((player_position.x - generated_area/2) / (generated_area*2))
	var tile_y = int((player_position.y - generated_area/2) / (generated_area*2))
	var rng = RandomNumberGenerator.new()
	
	for tx in range(-1, 2):
		for ty in range(-1, 2):
			#print("loading " + str(tile_x + tx) + " " + str(tile_y + ty))
			var count = load_ring_tile_from_data((tile_x + tx), (tile_y + ty))
			if count == 0:
				#print("Tile " + str(tile_x + tx) + " " + str(tile_y + ty) +" choosing to generate")
				#print("Choosing to generate a new tile")
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
						new_asteroid.tile_x = (tile_x + tx)
						new_asteroid.tile_y = (tile_y + ty)
						new_asteroid.uid = asteroid_uid_counter
						asteroid_uid_counter += 1
						list_of_asteroids.append(new_asteroid)
						add_child(new_asteroid)
						asteroid_count += 1
						
						keep_out_zones.append(Vector3(location.x, location.y, 300))
			else:
				#print("Tile " + str(tile_x + tx) + " " + str(tile_y + ty) +" choosing to load persistent")
				#print("Loaded persistent asteroid(s) " + str(count))
				pass
	
	last_generation_position = player_position
		
func unload_all_asteroids():
	for x in list_of_asteroids:
		var tile_map_data = x.store_tile_map_in_data()
		var asteroid_data = {
			"x":x.position.x,
			"y":x.position.y,
			"tile_map_data":tile_map_data,
			"tile_x":x.tile_x,
			"tile_y":x.tile_y,
			"uid":x.uid
		}
		
		var temp_counter = 0
		var found_uid = false
		for z in persistent_asteroid_data:
			if x.uid == z["uid"]:
				if z["tile_x"] == x.tile_x:
					pass
				else:
					print("Tile_x does not match!!! " + str(z["tile_x"]) + " " + str(x.tile_x))
					
				if z["tile_y"] == x.tile_y:
					pass
				else:
					print("Tile_y does not match!!!" + str(z["tile_y"]) + " " + str(x.tile_y))
				persistent_asteroid_data[temp_counter] = asteroid_data
				found_uid = true
				#print("Found UID")
			temp_counter += 1
		
		#print("Storing asteroid " + str(x.uid))
		if found_uid == false:
			persistent_asteroid_data.append(asteroid_data)
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
