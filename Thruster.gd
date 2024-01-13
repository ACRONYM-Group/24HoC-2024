extends AnimatedSprite2D

@export var thruster_0 = false;
@export var thruster_1 = false;
@export var thruster_2 = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	thruster_0 = false
	thruster_1 = false
	thruster_2 = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var frame_number = (1 if thruster_0 else 0) + (2 if thruster_1 else 0) + (4 if thruster_2 else 0)
	self.animation = "Thrust" + String.num(frame_number)
	
