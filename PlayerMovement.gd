extends CharacterBody2D

@export var accel_rate = 120
@export var rotation_rate = 10

@export var max_rotation_rate = 180.0

var rot_vel = 0

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var delta_rotation = Input.get_axis("rotate_left", "rotate_right")
	
	input_direction.y *= 2
	
	velocity += (input_direction * accel_rate).rotated(rotation) * delta
	rotation += rot_vel * delta
	rot_vel += delta_rotation * rotation_rate * delta
	
	if abs(rot_vel) >= max_rotation_rate:
		rot_vel = rot_vel / (abs(rot_vel)/ max_rotation_rate)
	else:
		rot_vel *= 1.0 - (3 * delta)
	
	$AnimatedSprite2D/LeftThruster.reset()
	$AnimatedSprite2D/RightThruster.reset()
		
	if input_direction.x > 0:
		$AnimatedSprite2D/LeftThruster.thruster_1 = true
	elif input_direction.x < 0:
		$AnimatedSprite2D/RightThruster.thruster_1 = true
		
	if input_direction.y > 0:
		$AnimatedSprite2D/LeftThruster.thruster_0 = true
		$AnimatedSprite2D/RightThruster.thruster_2 = true
	elif input_direction.y < 0:
		$AnimatedSprite2D/RightThruster.thruster_0 = true
		$AnimatedSprite2D/LeftThruster.thruster_2 = true
		
	if delta_rotation > 0:
		$AnimatedSprite2D/LeftThruster.thruster_2 = true
		$AnimatedSprite2D/RightThruster.thruster_2 = true
	elif delta_rotation < 0:
		$AnimatedSprite2D/LeftThruster.thruster_0 = true
		$AnimatedSprite2D/RightThruster.thruster_0 = true
		
	if Input.is_action_just_pressed("thrust"):
		$AnimatedSprite2D.play("thrusting")
	if Input.is_action_just_released("thrust"):
		$AnimatedSprite2D.play("default")
	if Input.is_action_pressed("thrust"):
		velocity += (Vector2(0, -1) * 5 * accel_rate).rotated(rotation) * delta
		
		

func _physics_process(delta):
	get_input(delta)
	move_and_slide()
