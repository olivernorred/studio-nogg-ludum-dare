class_name Drivable extends CharacterBody2D
@export var is_active = false
@export var start_available = false

var movement_target_position : Vector2
var state = "inactive" if start_available else "initialized"
var states = ["initialized", "npc_driving", "npc_waiting", "active", "inactive", "done"]
var can_be_selected = false

var npc_owner : NPC

@onready var entrance_exit_marker = $EntranceExitMarker

signal reached_hotel
signal accept_valet
signal eject_valet(position)


func _ready():
	$DrivingComponent.direction = rotation
	$DrivingComponent.is_active = is_active
	handle_sprite_change()
	if start_available:
		state = "inactive"

func _physics_process(delta):
	velocity = $DrivingComponent.velocity
	rotation = $DrivingComponent.direction
	move_and_collide(velocity)
	handle_animation()
	if is_active:
		if Input.is_action_just_pressed("vehicle_interact"):
			check_exit_vehicle()
	match state:
		"initialized":
			set_collision_layer_value(1, false)
			set_collision_mask_value(1, false)
			can_be_selected = false
		"npc_driving":
			set_collision_layer_value(1, false)
			set_collision_mask_value(1, false)
			$DrivingComponent.direction = (movement_target_position - position).normalized().angle()
			$DrivingComponent.gear = 1
			$DrivingComponent.velocity = $DrivingComponent.velocity.move_toward(Vector2.from_angle($DrivingComponent.direction) * $DrivingComponent.forward_speed * $DrivingComponent.gear, $DrivingComponent.acceleration)
			if (position - movement_target_position).length() < 10:
				reached_hotel.emit()
			can_be_selected = false
		"npc_waiting":
			set_collision_layer_value(1, true)
			set_collision_mask_value(1, true)
			can_be_selected = true
		"active":
			set_collision_layer_value(1, true)
			set_collision_mask_value(1, true)
			can_be_selected = false
		"inactive":
			set_collision_layer_value(1, true)
			set_collision_mask_value(1, true)
			can_be_selected = true
		"done":
			set_collision_layer_value(1, false)
			set_collision_mask_value(1, false)
			can_be_selected = false
	if $Label:
		$Label.text = state
		

func toggle_is_active():
	if !is_active:
		make_active()
	else:
		make_inactive()
func make_active(): 
	state = "active"
	is_active = true
	$DrivingComponent.is_active = is_active
	accept_valet.emit()
func make_inactive():
	is_active = false
	$DrivingComponent.is_active = is_active
	$DrivingComponent.velocity *= 0
	$DrivingComponent.turn = 0
	$DrivingComponent.gear = 0
	velocity = Vector2.ZERO
	
func check_exit_vehicle():
	state = "inactive"
	$DrivingComponent.velocity *= 0
	toggle_is_active()
	eject_valet.emit(to_global(entrance_exit_marker.position))

func handle_animation():
	pass
	
func handle_sprite_change():
	pass

func set_direction_to_rotation():
	$DrivingComponent.direction = global_rotation
	
