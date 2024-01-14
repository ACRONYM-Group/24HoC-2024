extends TileMap

const ICE_TILE = Vector2i(0, 0)
const ROCK_TILE = Vector2i(0, 1)

var queue = []
var last_frame = []

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_random()
	
func generate_random():
	var rng = RandomNumberGenerator.new()
	var size = rng.randi_range(6, 12)
	var types = [[4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16], [17]]
	var index = rng.randi_range(0, types.size() - 1)
	
	generate_tile_map(types[index], size)

func generate_tile_map(material, size: int = 10):
	var tm = self
	var rng = RandomNumberGenerator.new()
	
	var next_to_update = [Vector2i(0, 0)]
	
	for i in range(size):
		var next_update_set = []
		
		for update_tile in next_to_update:
			if i < size * 6 / 10:
				var index = rng.randi_range(0, material.size() - 1)
				tm.set_cell(0, update_tile, material[index], Vector2i(0, 0))
			else:
				tm.set_cell(0, update_tile, rng.randi_range(0,2), Vector2i(0, 0))
				
			var pattern = tm.get_pattern(0, tm.get_surrounding_cells(update_tile))
			for neighbor in tm.get_surrounding_cells(update_tile):
				if neighbor not in tm.get_used_cells(0):
					if rng.randi_range(0, 10) < 6:
						next_update_set.append(neighbor)
		next_to_update = next_update_set

func get_free_neighbors(tm, filled, cell):
	var neighbors = tm.get_surrounding_cells(cell)
	var free = []
	
	for n in neighbors:
		if n not in filled:
			free.append(n)
			
	return free
	
func get_populated_after(tm, filled, cell):
	var neighbors = tm.get_surrounding_cells(cell)
	var pop = []
	
	neighbors.append(neighbors[0])
	var can_return = false
	
	for n in neighbors:
		if n not in filled:
			can_return = true
		else:
			if can_return:
				pop.append(n)
				can_return = false
				
	return pop

func first_not_populated_not_in(tm, filled, cell, not_in):
	var next_populated = get_populated_after(tm, filled, cell)
	for next in next_populated:
		if next not in not_in:
			return next
	if next_populated.size() == 0:
		return null
	return next_populated[0]
	
func drill_collide(location: Vector2, collect: bool):
	last_frame.push_back(location)
	for entry in queue:
		if entry[0] == location:
			return
	queue.push_back([location, 0, collect])
		
func drill_collide_internal(location: Vector2, collect: bool):
	var tm = self
	var local = global_transform.inverse() * location;
	var tile_pos = tm.local_to_map(local)
	
	var cell_type = tm.get_cell_source_id(0, tile_pos)
	
	# tm.clear()
	tm.erase_cell(0, tile_pos)
	
	tm.update_internals()
	
	if cell_type != -1 and collect:
		$"../../DrillSound".play(0.0)
		
		match cell_type:
			0, 1, 2:
				$"../../Player2/Inventory".add_new_resource("ice", 1)
			4:
				$"../../Player2/Inventory".add_new_resource("amulite", 1)
			5, 6, 7:
				$"../../Player2/Inventory".add_new_resource("metal", 1)
			9, 10, 11, 12:
				$"../../Player2/Inventory".add_new_resource("silicates", 1)
			13, 14, 15, 16:
				$"../../Player2/Inventory".add_new_resource("carbon", 1)
			17:
				$"../../Player2/Inventory".add_new_resource("exotics", 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for entry in queue:
		entry[1] -= delta
	var i = 0;
	while i < queue.size():
		if queue[i][1] < 0:
			# if queue[i][0] in last_frame:
			self.drill_collide_internal(queue[i][0], queue[i][2])
			queue.remove_at(i)
		else:
			i += 1
			
	last_frame = []
