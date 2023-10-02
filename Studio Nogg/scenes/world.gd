class_name GameWorld extends Node2D

var stored_valet

@export var npc_queue : Array[NPC]
var npcs_traveling = []

@onready var entrancePathFollow = $EntrancePath/EntranceSmartPathFollow2D

func _ready():
	stored_valet = $Valet
	for vehicle in get_tree().get_nodes_in_group("Vehicles"):
		vehicle.eject_valet.connect(_on_vehicle_valet_ejected)


func _on_valet_interacted_with_vehicle(vehicle):
	vehicle.make_active()
	$Camera2D.current_target = vehicle
	stored_valet = $Valet
	remove_child(stored_valet)

func _on_vehicle_valet_ejected(drop_position):
	if !has_node("Valet"):
		print("valet ejected")
		stored_valet.position = drop_position
		add_child(stored_valet)
		$Camera2D.current_target = stored_valet
	else:
		print("valet exists")



func _on_send_npc_timer_timeout():
	send_npc()

func send_npc():
	if npc_queue.size() > 0:
		var npc_to_send = npc_queue.pop_front()
		npcs_traveling.append(npc_to_send)
		remove_child(npc_to_send)
		remove_child(npc_to_send.controlled_car)
		npc_to_send.controlled_car.rotation = 0
		npc_to_send.controlled_car.position = Vector2(0,0)
		entrancePathFollow.add_child(npc_to_send.controlled_car)
#		entrancePathFollow.speed = 1
		entrancePathFollow.speed = npc_to_send.controlled_car.get_node("DrivingComponent").forward_speed
		entrancePathFollow.start_traveling()



func _on_entrance_smart_path_follow_2d_path_finished():
	if npcs_traveling.size() > 0:
		var traveling_npc = npcs_traveling.pop_front()
		var traveling_car = traveling_npc.controlled_car
		traveling_car.position = traveling_car.global_position
		traveling_car.rotation = entrancePathFollow.rotation
		traveling_car.make_inactive()
		entrancePathFollow.remove_child(traveling_car)
		add_child(traveling_car)
		
		traveling_npc.state = "going_into_building"
		add_child(traveling_npc)
