extends RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		if self.get_collider().has_method("drill_collide"):
			self.get_collider().drill_collide(self.get_collision_point())
