extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(str($CanvasLayer.visible) + " " + str(not $CanvasLayer.visible))
	$background.position = $Player2.position
	if (not $CanvasLayer.visible) == true:
		#print("True")
		$Player2.set_allow_input(true)
	else:
		$Player2.set_allow_input(false)
		#print("False")
		
	$MiniMap/Minimap.render_map($Asteroids.list_of_asteroids, $Player2.position, $Asteroids.generated_area, $Player2.rotation)
	
	if abs($Player2.position.x - $Asteroids.last_generation_position.x) > $Asteroids.generated_area or abs($Player2.position.y - $Asteroids.last_generation_position.y) > $Asteroids.generated_area:
		$Asteroids.generate_ring_tile($Player2.position)
