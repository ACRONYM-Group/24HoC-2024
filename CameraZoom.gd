extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta = Input.get_axis("zoom_in", "zoom_out")
	zoom += Vector2(delta, delta) * 0.1
