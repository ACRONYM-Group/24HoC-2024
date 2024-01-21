extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_all_qty(d):
	for key in d:
		if key == "ice":
			set_ice_qty(d[key])
		elif key == "carbon":
			set_carbon_qty(d[key])
		elif key == "amulite":
			set_amulite_qty(d[key])
		elif key == "silicates":
			set_silicates_qty(d[key])
		elif key == "metal":
			set_metal_qty(d[key])
		elif key == "exotics":
			set_exotics_qty(d[key])

func set_ice_qty(amount):
	$IceBox/IceQty.text = str(amount)

func set_carbon_qty(amount):
	$CarbonBox/CarbonQty.text = str(amount)

func set_amulite_qty(amount):
	$AmuliteBox/AmuliteQty.text = str(amount)
	
func set_metal_qty(amount):
	$MetalBox/MetalQty.text = str(amount)
	
func set_silicates_qty(amount):
	$SilicatesBox/SilicatesQty.text = str(amount)
	
func set_exotics_qty(amount):
	$ExoticsBox/ExoticsQty.text = str(amount)
