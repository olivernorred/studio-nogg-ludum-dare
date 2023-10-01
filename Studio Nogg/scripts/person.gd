class_name Person extends CharacterBody2D


@export var speed = 100.0
@export var acceleration = 100


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	velocity = velocity.move_toward(direction*speed, acceleration)
	if velocity.length() > 0:
		rotation = velocity.angle()
	move_and_slide()
	check_vehicle()
	handle_animation()

func check_vehicle():
	pass
	
func handle_animation():
	pass
