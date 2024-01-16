extends Control

var asteroids_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func render_map(asteroids, center_position, generated_area, player_rotation):
	var rng = RandomNumberGenerator.new()
		
	var last_i = 0
	for i in range(asteroids.size()):
		last_i = i
		var x = asteroids[i]
		var z = ""
		if i < asteroids_list.size():
			z = asteroids_list[i]
		else:
			var new_asteroid = Sprite2D.new()
			new_asteroid.texture = load("res://Sprites/Minimap/Asteroid.png")
			
			asteroids_list.append(new_asteroid)
			
			add_child(new_asteroid)
			z = asteroids_list[i]
		
		
		var x_coord = (x.position.x - center_position.x) * (80.0/generated_area)
		var y_coord = (x.position.y - center_position.y) * (80.0/generated_area)
		
			
		var new_vec = Vector2(x_coord, y_coord)
			
		new_vec = new_vec.rotated(-player_rotation)
			
		new_vec.x = new_vec.x + 80
		new_vec.y = new_vec.y + 80
		
		new_vec.x = new_vec.x + 20 #Fudge factor for some reason?
		new_vec.y = new_vec.y + 22 #Fudge factor for some reason?
	
		if new_vec.x < 0:
			new_vec.x = 1000
		if new_vec.y > 200:
			new_vec.y = -100
			
		new_vec.x = new_vec.x -195
			
		z.position = new_vec
		#print("Spawning at " + str(x.position.x) + " " + str(center_position.x) + " " + str(190.0/generated_area) + " " + str(generated_area))
		
	
	var list_of_asteroids_to_remove = []
	if last_i+1 < asteroids_list.size():
		for i in range(last_i, asteroids_list.size()):
			remove_child(asteroids_list[i])
			list_of_asteroids_to_remove.append(i)
			
	for x in list_of_asteroids_to_remove:
		asteroids_list.remove_at(x)
			
