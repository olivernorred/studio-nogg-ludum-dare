class_name GameWorld extends Node2D



var last_state_valet

func _ready():
	last_state_valet = $Valet
	for vehicle in get_tree().get_nodes_in_group("Vehicles"):
		vehicle.eject_valet.connect(_on_vehicle_valet_ejected)

func _on_valet_interacted_with_vehicle(vehicle):
	vehicle.toggle_is_active()
	last_state_valet = $Valet
	remove_child(last_state_valet)
	$Camera2D.current_target = vehicle

func _on_vehicle_valet_ejected(drop_position):
	print("valet ejected")
	last_state_valet.position = drop_position
	add_child(last_state_valet)
	$Camera2D.current_target = last_state_valet
