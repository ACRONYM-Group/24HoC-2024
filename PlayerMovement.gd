extends RigidBody2D

@export var accel_rate = 120
@export var rotation_rate = 10

@export var max_rotation_rate = 180.0

var rot_vel = 0
var ship_thrust = 250
var torque = 100

func _integrate_forces(state):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var delta_rotation = Input.get_vector("rotate_left", "rotate_right", "", "").x
	
	if input_direction.length() > 0:
		state.apply_central_force((input_direction * ship_thrust).rotated(self.rotation))
	else:
		state.apply_central_force(Vector2())
	
	state.apply_torque(delta_rotation * torque)

func get_input(delta):
	pass

func _physics_process(delta):
	pass
	#get_input(delta)
	#move_and_slide()
