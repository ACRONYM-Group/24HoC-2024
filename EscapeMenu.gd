extends Control
@export var test = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($Button.is_visible())
	if $"../../StationMenu".visible == false:
		if Input.is_action_just_pressed("ui_cancel"):
			if self.get_parent().visible:
				self.get_parent().hide()
				test = false
				get_tree().paused = false
			else:
				self.get_parent().show()
				test = true
				get_tree().paused = true


func _on_button_pressed():
	get_tree().quit()
	


func _on_button_2_pressed():
	self.get_parent().hide()
	test = false
	get_tree().paused = false
