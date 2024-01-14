extends TileMap

const ICE_TILE = Vector2i(0, 0)
const ROCK_TILE = Vector2i(0, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_random()
	regenerate_mesh()
	
func generate_random():
	var rng = RandomNumberGenerator.new()
	var size = rng.randi_range(6, 12)
	var types = [[3], [4], [5, 6, 7, 8]]
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

func regenerate_mesh():
	"""
	var tm = $TileMap
	var used_cells = tm.get_used_cells(0)
	
	for current in used_cells:
		if get_free_neighbors(tm, used_cells, current).size() == 6:
			tm.erase_cell(0, current)
			
	used_cells = tm.get_used_cells(0)
	
	if used_cells.size() < 2:
		return
	
	var edge = []
	
	var start_cell = used_cells[used_cells.size() - 1];
	while get_free_neighbors(tm, used_cells, start_cell).size() == 0:
		var surround = tm.get_surrounding_cells(start_cell)
		start_cell = surround[0]
	
	edge.append(tm.map_to_local(start_cell))
	var raw_edge = [start_cell]
	var last = start_cell
	
	while true:
		var next = first_not_populated_not_in(tm, used_cells, last, raw_edge)
		if next == null:
			break
		if next != raw_edge[0]:
			edge.append(tm.map_to_local(next))
			raw_edge.append(next)
			last = next
		else:
			break
	
	$Collider.set_deferred("polygon", PackedVector2Array(edge))"""

func drill_collide(location: Vector2):
	var tm = self
	var local = global_transform.inverse() * location;
	var tile_pos = tm.local_to_map(local)
	
	# tm.clear()
	tm.erase_cell(0, tile_pos)
	
	regenerate_mesh()
	tm.update_internals()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
