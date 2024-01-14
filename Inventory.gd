extends Node

@export var ice_quantity = 0
@export var metal_quantity = 0
@export var amulite_quantity = 0
@export var carbon_quantity = 0
@export var exotics_quantity = 0
@export var silicates_quantity = 0
@export var hp = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"../../InventoryBarCanvas/InventoryBar".set_ice_qty(ice_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_metal_qty(metal_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_amulite_qty(amulite_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_carbon_qty(carbon_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_exotics_qty(exotics_quantity)
	$"../../InventoryBarCanvas/InventoryBar".set_silicates_qty(silicates_quantity)
	$"../../StatsBarCanvas/StatBars".set_hp_bar_perc(hp)
		
	if Input.is_action_just_pressed("key7"):
		hp += 1
	
	if Input.is_action_just_pressed("key8"):
		hp -= 1
		

func add_new_resource(material_name, amount):
	if material_name == "ice":
		ice_quantity += amount
	elif material_name == "metal":
		metal_quantity += amount
	elif material_name == "amulite":
		amulite_quantity += amount
	elif material_name == "carbon":
		carbon_quantity += amount
	elif material_name == "exotics":
		exotics_quantity += amount
	elif material_name == "silicates":
		silicates_quantity += amount
		
func delta_hp(amount):
	self.hp += amount
