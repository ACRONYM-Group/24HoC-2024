extends Label

var timer = 0;
var total_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	timer = 0.25
	total_timer = 1.8
	self.visible = true
	$AudioStreamPlayer2.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if total_timer > 0 and total_timer <= delta:
		$"../../StationMenu".visible = true
		$"../../StationMenu/Control".start($"../../Player2/Inventory".to_dict())
		$"../../Player2/Inventory".clear()
		get_tree().paused = true
	timer -= delta
	total_timer -= delta
	if total_timer > 0:
		if timer < 0:
			timer = 0.25
			self.visible = !visible
	if total_timer < 0:
		self.visible = false
