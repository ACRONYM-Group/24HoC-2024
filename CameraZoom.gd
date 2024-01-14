extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("zoom_scroll_in"):
		zoom += Vector2(delta, delta) * 10
	elif Input.is_action_just_released("zoom_scroll_out"):
		zoom += Vector2(delta, delta) * -10