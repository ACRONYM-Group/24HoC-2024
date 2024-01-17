extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_fuel_bar_perc(amount):
	$FuelBar.value = amount
	
func set_hp_bar_perc(amount):
	$HPBar.value = amount
