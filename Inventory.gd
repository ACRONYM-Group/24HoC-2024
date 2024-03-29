extends Node

@export var ice_quantity = 0
@export var metal_quantity = 0
@export var amulite_quantity = 0
@export var carbon_quantity = 0
@export var exotics_quantity = 0
@export var silicates_quantity = 0
@export var hp = 100
@export var fuel_quantity = 1000
var max_cargo_quantity = 100

func to_dict():
	var d = {}
	d["ice"] = ice_quantity
	d["metal"] = metal_quantity
	d["amulite"] = amulite_quantity
	d["carbon"] = carbon_quantity
	d["exotics"] = exotics_quantity
	d["silicates"] = silicates_quantity
	
	return d

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_total_count():
	return ice_quantity + metal_quantity + amulite_quantity + carbon_quantity + exotics_quantity + silicates_quantity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"../../InventoryBarCanvas/InventoryBar".set_ice_qty(ice_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_metal_qty(metal_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_amulite_qty(amulite_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_carbon_qty(carbon_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_exotics_qty(exotics_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_silicates_qty(silicates_quantity)
	$"../../StatsBarCanvas/StatBars".set_hp_bar_perc(hp)
	$"../../StatsBarCanvas/StatBars".set_fuel_bar_perc(fuel_quantity/10)
		
	if Input.is_action_just_pressed("key7"):
		hp += 1
	
	if Input.is_action_just_pressed("key8"):
		hp -= 1
		

func add_new_resource(material_name, amount):
	if material_name == "ice":
		if ice_quantity + amount <= max_cargo_quantity:
			ice_quantity += amount
	elif material_name == "metal":
		if metal_quantity + amount <= max_cargo_quantity:
			metal_quantity += amount
	elif material_name == "amulite":
		if amulite_quantity + amount <= max_cargo_quantity:
			amulite_quantity += amount
	elif material_name == "carbon":
		if carbon_quantity + amount <= max_cargo_quantity:
			carbon_quantity += amount
	elif material_name == "exotics":
		if exotics_quantity + amount <= max_cargo_quantity:
			exotics_quantity += amount
	elif material_name == "silicates":
		if silicates_quantity + amount <= max_cargo_quantity:
			silicates_quantity += amount
		
		
func are_engines_operational():
	if fuel_quantity > 0:
		return true
	else:
		return false
		
func consume_some_fuel(amount):
	fuel_quantity -= amount
		
func clear():
	ice_quantity = 0
	metal_quantity = 0
	amulite_quantity = 0
	carbon_quantity = 0
	exotics_quantity = 0
	silicates_quantity = 0
		
func delta_hp(amount):
	self.hp += amount
	
	if self.hp <= 0:
		get_tree().change_scene_to_file("res://GameOver.tscn")
	
func calculate_collide():
	var speed = self.get_parent().last_tick_rate
	if speed > 200:
		delta_hp(-((speed-200) * (speed-200)/10000))
	
	self.get_parent().last_tick_rate = 0


func _on_player_2_body_entered(body):
	calculate_collide()


func _on_player_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	calculate_collide()
	pass # Replace with function body.
