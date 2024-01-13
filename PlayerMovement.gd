extends CharacterBody2D

@export var accel_rate = 25
@export var rotation_rate = 0.05

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var delta_rotation = Input.get_vector("rotate_left", "rotate_right", "", "").x
	velocity += (input_direction * accel_rate).rotated(rotation)
	rotation += delta_rotation * rotation_rate

func _physics_process(delta):
	get_input()
	move_and_slide()
