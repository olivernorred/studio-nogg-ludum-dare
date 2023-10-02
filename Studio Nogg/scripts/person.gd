class_name Person extends CharacterBody2D


@export var speed : float
@export var acceleration = 100

func _physics_process(delta):
	
	handle_movement()
	handle_path()
	check_vehicle()
	handle_animation()
	move_and_slide()


func check_vehicle():
	pass
	
func handle_animation():
	pass

func handle_path():
	pass

func handle_movement():
	pass
