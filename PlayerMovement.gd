extends RigidBody2D

@export var accel_rate = 120
@export var rotation_rate = 10

@export var max_rotation_rate = 180.0

var rot_vel = 0
var rcs_thrust = 250
var torque = 100
var main_thrust = 1000

func _integrate_forces(state):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var delta_rotation = Input.get_vector("rotate_left", "rotate_right", "", "").x

	
	

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var delta_rotation = Input.get_vector("rotate_left", "rotate_right", "", "").x

	rot_vel *= 1.0 - (3 * delta)
	
	if Input.is_action_pressed("thrust"):
		apply_central_force((Vector2(0, -1) * 2 * main_thrust).rotated(self.rotation))

	if input_direction.length() > 0:
		apply_central_force((input_direction * 2 * rcs_thrust).rotated(self.rotation))
	
	apply_torque(delta_rotation * torque * 5)
	
	$AnimatedSprite2D/LeftThruster.reset()
	$AnimatedSprite2D/RightThruster.reset()
	
	if ( Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right") || Input.is_action_just_pressed("up") || Input.is_action_just_pressed("down")) and input_direction != Vector2(0, 0):
		$"../AudioStreamPlayer".play(0.0)
		
	if (Input.is_action_just_pressed("rotate_left") || Input.is_action_just_pressed("rotate_right")) && delta_rotation != 0:
		$"../AudioStreamPlayer".play(0.0)
		
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
	#if Input.is_action_pressed("thrust"):
		#velocity += (Vector2(0, -1) * 5 * accel_rate).rotated(rotation) * delta
		
		

func _physics_process(delta):
	get_input(delta)
	#move_and_slide()
