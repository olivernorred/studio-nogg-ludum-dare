class_name Drivable extends CharacterBody2D
@export var is_active = false

@onready var entrance_exit_marker = $EntranceExitMarker

signal eject_valet(position)

func _ready():
	$DrivingComponent.direction = rotation
	$DrivingComponent.is_active = is_active

func _physics_process(delta):
	velocity = $DrivingComponent.velocity
	rotation = $DrivingComponent.direction
	move_and_collide(velocity)
	handle_animation()
	
	if is_active:
		if Input.is_action_just_pressed("vehicle_interact"):
			check_exit_vehicle()
		
		

func toggle_is_active():
	is_active = !is_active
	$DrivingComponent.is_active = is_active
func make_active():
	is_active = true
	$DrivingComponent.is_active = is_active
func make_inactive():
	is_active = false
	$DrivingComponent.is_active = is_active	
func check_exit_vehicle():
	$DrivingComponent.velocity *= 0
	toggle_is_active()
	eject_valet.emit(to_global(entrance_exit_marker.position))
	

func handle_animation():
	pass
