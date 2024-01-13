extends CharacterBody2D

@export var accel_rate = 120
@export var rotation_rate = 10

@export var max_rotation_rate = 180.0

var rot_vel = 0

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var delta_rotation = Input.get_vector("rotate_left", "rotate_right", "", "").x
	velocity += (input_direction * accel_rate).rotated(rotation) * delta
	rotation += rot_vel * delta
	rot_vel += delta_rotation * rotation_rate * delta
	
	if abs(rot_vel) >= max_rotation_rate:
		rot_vel = rot_vel / (abs(rot_vel)/ max_rotation_rate)
	else:
		rot_vel *= 0.95

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
