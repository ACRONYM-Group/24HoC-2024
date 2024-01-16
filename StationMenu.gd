extends Control
@export var test = true

var current_inventory = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(d):
	for key in d:
		if key in current_inventory:
			current_inventory[key] += d[key]
		else:
			current_inventory[key] = d[key]
			
	print(current_inventory)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($Button.is_visible())
	if Input.is_action_just_pressed("ui_cancel"):
		if self.get_parent().visible:
			self.get_parent().hide()
			test = false
			get_tree().paused = false


func _on_button_pressed():
	get_tree().quit()


func _on_button_2_pressed():
	self.get_parent().hide()
	test = false
	get_tree().paused = false
	
