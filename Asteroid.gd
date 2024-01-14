extends RigidBody2D

const ICE_TILE = Vector2i(0, 0)
const ROCK_TILE = Vector2i(0, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_tile_map()
	regenerate_mesh()

func generate_tile_map():
	var tm = $TileMap
	var rng = RandomNumberGenerator.new()
	
	var next_to_update = [Vector2i(0, 0)]
	
	for i in range(7):
		var next_update_set = []
		
		for update_tile in next_to_update:
			if i < 6:
				tm.set_cell(0, update_tile, 3, Vector2i(0, 0))
			else:
				tm.set_cell(0, update_tile, rng.randi_range(0,2), Vector2i(0, 0))
				
			var pattern = tm.get_pattern(0, tm.get_surrounding_cells(update_tile))
			for neighbor in tm.get_surrounding_cells(update_tile):
				if neighbor not in tm.get_used_cells(0):
					if rng.randi_range(0, 10) < 8:
						next_update_set.append(neighbor)
		next_to_update = next_update_set

func get_free_neighbors(tm, filled, cell):
	var neighbors = tm.get_surrounding_cells(cell)
	var free = []
	
	for n in neighbors:
		if n not in filled:
			free.append(n)
			
	return free
	
func get_first_populated(tm, filled, cell):
	var neighbors = tm.get_surrounding_cells(cell)
	var free = []
	
	neighbors.append(neighbors[0])
	var can_return = false
	
	for n in neighbors:
		if n not in filled:
			can_return = true
		else:
			if can_return:
				return n

func regenerate_mesh():
	var tm = $TileMap
	var used_cells = tm.get_used_cells(0)
	
	var edge = []
	
	var start_cell = used_cells[used_cells.size() - 1];
	while get_free_neighbors(tm, used_cells, start_cell).size() == 0:
		var surround = tm.get_surrounding_cells(start_cell)
		start_cell = surround[0]
	
	edge.append(tm.map_to_local(start_cell))
	var raw_edge = [start_cell]
	var last = start_cell
	
	while true:
		print(last)
		var next = get_first_populated(tm, used_cells, last)
		if next == null:
			break
		if next not in raw_edge:
			edge.append(tm.map_to_local(next))
			raw_edge.append(next)
			last = next
		else:
			break
	
	$Collider.polygon = PackedVector2Array(edge)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
