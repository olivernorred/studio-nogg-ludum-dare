class_name NPC extends Person

var state = "in_queue"

@export var vehicle : Drivable
@export var path_to_follow : Path2D
@export var tip = 60
@export var tip_decline_rate = 0.05
@export var exit_hotel_timer_time = 10

var possible_textures = [
	"res://NPCs/NPC1.png",
	"res://NPCs/NPC2.png",
	"res://NPCs/NPC3.png",
	"res://NPCs/NPC4.png",
	"res://NPCs/NPC5.png",
	"res://NPCs/NPC6.png",
	"res://NPCs/NPC7.png",
	"res://NPCs/NPC8.png",
	"res://NPCs/NPC9.png",
	"res://NPCs/NPC10.png",
]


var path_index = 0

var ready_to_enter_car = false

var states = ["in_queue", "in_car_entering", "waiting_for_player", "going_into_building", "exiting_building", "waiting_for_car", "in_car_exiting"]

signal entered_hotel
signal exit_hotel_timer_timeout
signal attempted_to_enter_vehicle

func _ready():
	$ExitHotelTimer.wait_time = exit_hotel_timer_time
	possible_textures.shuffle()
	var chosen_texture = possible_textures.pop_front()
	$Sprite2D.texture = load(chosen_texture)
	vehicle.npc_owner = self
	

func handle_movement():
	var direction = Vector2(0,0)
	match state:
		"in_queue":
			pass
		"in_car_entering":
			pass
		"waiting_for_player":
			tip -= tip_decline_rate
			pass
		"going_into_building":
			direction = (get_parent().get_node("HotelEntranceArea").position - position).normalized()
		"exiting_building":
			set_collision_mask_value(4, true)
			set_collision_layer_value(4, true)
			direction = (get_parent().get_node("NPCWaitingArea").position - position).normalized()
			ready_to_enter_car = true
		"waiting_for_car":
			tip -= tip_decline_rate
			ready_to_enter_car = true
		
		"in_car_exiting":
			pass
	
	velocity = velocity.move_toward(direction*speed, acceleration)
	if velocity.length() > 0:
		rotation = velocity.angle()
	$Label.text = state
	$RotationLock/TipLabel.text = "$%s" % str(round(tip))
	
func check_vehicle():
	pass




func _on_car_checker_body_entered(body):
	if body == vehicle and ready_to_enter_car:
		attempted_to_enter_vehicle.emit()
			





func _on_hotel_checker_area_entered(area):
	entered_hotel.emit()
	$ExitHotelTimer.start()
	



func _on_exit_hotel_timer_timeout():
	exit_hotel_timer_timeout.emit()


func _on_waiting_area_checker_area_entered(area):
	state = "waiting_for_car"

func handle_animation():
	if velocity.length() > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
