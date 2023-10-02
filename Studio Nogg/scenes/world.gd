class_name GameWorld extends Node2D

var stored_valet


var npcs_traveling = []
var npcs_in_building = []

@onready var stored_transform_reset = $GlobalTransformSetter.transform
@onready var entrancePathFollow = $EntrancePath/EntranceSmartPathFollow2D
@onready var exitPathFollow = $ExitPath/ExitSmartPathFollow2D

@onready var npc_queue = get_tree().get_nodes_in_group("NPCs")

func _ready():
	stored_valet = $Valet
	for vehicle in get_tree().get_nodes_in_group("Vehicles"):
		vehicle.eject_valet.connect(eject_valet_from_vehicle)
		vehicle.reached_hotel.connect(_on_vehicle_reached_hotel)
	for npc in get_tree().get_nodes_in_group("NPCs"):
		npc.entered_hotel.connect(func(): put_npc_in_building(npc))
		npc.exit_hotel_timer_timeout.connect(func(): send_npc_out_of_building(npc))
		npc.attempted_to_enter_vehicle.connect(func(): send_npc_away(npc))


func _on_valet_interacted_with_vehicle(vehicle):
	match vehicle.state:
		"npc_driving", "active", "done":
			print("vehicle not available")
			return
		"npc_waiting":
			send_npc_to_building(vehicle.npc_owner)
	vehicle.make_active()
	$Camera2D.current_target = vehicle
	stored_valet = $Valet
	remove_child(stored_valet)

func eject_valet_from_vehicle(drop_position):
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
	if npc_queue.size() > 0 and entrancePathFollow.progress_ratio == 0:
		var npc_to_send = npc_queue.pop_front()
		npcs_traveling.append(npc_to_send)
		remove_child(npc_to_send)
		npc_to_send.state = "in_car_entering"
		npc_to_send.vehicle.state = "npc_driving"
		npc_to_send.vehicle.position = $StartOfPullUpZoneMarker.position
		npc_to_send.vehicle.movement_target_position = $EndOfPullUpZoneMarker.position
		
		

func put_vehicle_on_path(vehicle, pathFollowNode):
	vehicle.make_inactive()
	vehicle.get_node("DrivingComponent").direction = 0
	vehicle.rotation = 0
	vehicle.position = Vector2(0,0)
	remove_child(vehicle)
	pathFollowNode.add_child(vehicle)
	pathFollowNode.speed = vehicle.get_node("DrivingComponent").forward_speed
	pathFollowNode.start_traveling()



func _on_vehicle_reached_hotel():
	if npcs_traveling.size() > 0:
		var traveling_npc = npcs_traveling.pop_front()
		var traveling_vehicle = traveling_npc.vehicle
		traveling_vehicle.position = traveling_vehicle.global_position
		traveling_vehicle.make_inactive()
		traveling_vehicle.set_direction_to_rotation()
		entrancePathFollow.remove_child(traveling_vehicle)
		entrancePathFollow.progress = 0
		add_child(traveling_vehicle)
		
		eject_npc_from_car(traveling_npc)
		add_child(traveling_npc)

func eject_npc_from_car(npc):
	npc.state = "waiting_for_player"
	npc.vehicle.state = "npc_waiting"
	npc.position = npc.vehicle.get_node("EntranceExitMarker").global_position
	
func send_npc_to_building(npc):
	npc.state = "going_into_building"

func put_npc_in_building(npc):
	npcs_in_building.append(npc)
	npc.position = Vector2(-999999, -999999)

func send_npc_out_of_building(npc):
	npcs_in_building.pop_at(npcs_in_building.find(npc))
	npc.position = $HotelExitMarker.position
	npc.state = "exiting_building"
	
func send_npc_away(npc):
	npc.vehicle.check_exit_vehicle()
	var newPathFollowNode = SmartPathFollow2D.new()
	newPathFollowNode.path_finished.connect(func(): _on_exit_path_finished(newPathFollowNode))
	put_vehicle_on_path(npc.vehicle, newPathFollowNode)
	$ExitPath.add_child(newPathFollowNode)
	npc.state = "in_car_exiting"
	npc.vehicle.state = "done"
	leave_tip(npc)
	remove_child(npc)
	print("attempted_to_enter_vehicle")
	
func leave_tip(npc):
	var tip_text = FadingLabel.new()
	tip_text.position = npc.global_position
	tip_text.text = "+%s" % str(round(npc.tip))
	Global.money += round(npc.tip)
	npc.tip = 0
	add_child(tip_text)
	tip_text.queue_free()

func _on_exit_path_finished(pathFollow):
	for child in exitPathFollow.get_children():
		child.queue_free()
	exitPathFollow.progress = 0
