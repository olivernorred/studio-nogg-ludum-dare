class_name NPC extends Person

var state = "in_queue"

@export var controlled_car : Drivable
@export var path_to_follow : Path2D
var path_index = 0

var ready_to_enter_car = false

var states = ["in_queue", "in_car_entering", "going_into_building", "exiting_building", "in_car_exiting"]


func handle_movement():
	var direction = Vector2(0,0)
	match state:
		"in_queue":
			pass
		"in_car_entering":
			pass
		"going_into_building":
#			direction = Vector2.from_angle(position.angle_to(get_parent().get_node("HotelEntranceMarker").position))
			pass
	
	velocity = velocity.move_toward(direction*speed, acceleration)
	if velocity.length() > 0:
		rotation = velocity.angle()
		
	
func check_vehicle():
	pass




func _on_car_checker_body_entered(body):
	if body == controlled_car:
		ready_to_enter_car = true


