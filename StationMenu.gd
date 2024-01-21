extends Control
@export var test = true

var current_inventory = {}

@export var current_ship_fuel_qty = 0
@export var current_station_fuel_qty = 0
@export var should_offload = false
var ice_process_timer = 0

var ship_inventory = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(d):
	should_offload = false
	ship_inventory = d
	
			
	#print(current_inventory)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($Button.is_visible())
	$CargoContainer/Control/StationQty.set_all_qty(current_inventory)
	$CargoContainer/Control/ShipQty.set_all_qty(ship_inventory)
	ice_process_timer += delta
	
	if ice_process_timer > 1:
		ice_process_timer = 0
		if "ice" in current_inventory and current_inventory["ice"] >= 1:
			current_inventory["ice"] -= 1
			current_station_fuel_qty += 3
	
	$FuelContainer/Control/FuelBar.set_value(current_ship_fuel_qty/10)
	$FuelContainer/Control/StationFuelbar.set_value(current_station_fuel_qty/100)
	if Input.is_action_just_pressed("ui_cancel"):
		if self.get_parent().visible:
			self.get_parent().hide()
			test = false
			get_tree().paused = false

func _on_back_button_pressed():
	self.get_parent().hide()
	test = false
	get_tree().paused = false


func _on_fuel_button_pressed():
	if $FuelContainer.visible:
		$FuelContainer.hide()
	else:
		$FuelContainer.show()
		$CargoContainer.hide()


func _on_refill_button_pressed():
	if current_station_fuel_qty >= (1000-current_ship_fuel_qty):
		current_station_fuel_qty -= (1000-current_ship_fuel_qty)
		current_ship_fuel_qty = 1000
	else:
		current_ship_fuel_qty += current_station_fuel_qty
		current_station_fuel_qty = 0
	self.get_parent().get_parent().refill_ship_from_station(current_ship_fuel_qty, current_station_fuel_qty)


func _on_offload_button_pressed():
	should_offload = true
	for key in ship_inventory:
		if key in current_inventory:
			current_inventory[key] += ship_inventory[key]
		else:
			current_inventory[key] = ship_inventory[key]
		ship_inventory[key] = 0
	pass # Replace with function body.


func _on_cargo_button_pressed():
	if $CargoContainer.visible:
		$CargoContainer.hide()
	else:
		$CargoContainer.show()
		$FuelContainer.hide()
