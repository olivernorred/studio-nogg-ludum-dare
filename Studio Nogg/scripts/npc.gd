class_name NPC extends Person

var state = 0

@export var controlled_car : Drivable
@export var path_to_follow : Path2D
var path_index = 0

var ready_to_enter_car = false

var states = ["in_car_entering", "going_into_building", "exiting_building", "in_car_exiting"]


func handle_movement():
	if state == "going_into_building":
		
	
func check_vehicle():
	pass




func _on_car_checker_body_entered(body):
	if body == controlled_car:
		ready_to_enter_car = true


