extends Node2D

@export var inventory_amt: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every fr. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(str($CanvasLayer.visible) + " " + str(not $CanvasLayer.visible))
	$background.position = $Player2.position
	if (not $CanvasLayer.visible) == true:
		$Player2.set_allow_input(true)
	else:
		$Player2.set_allow_input(false)
		
	$MiniMap/Minimap.render_map($Asteroids.list_of_asteroids, $Player2.position, $Asteroids.generated_area, $Player2.rotation)
	
	if abs($Player2.position.x - $Asteroids.last_generation_position.x) > $Asteroids.generated_area or abs($Player2.position.y - $Asteroids.last_generation_position.y) > $Asteroids.generated_area:
		$Asteroids.generate_ring_tile($Player2.position)
