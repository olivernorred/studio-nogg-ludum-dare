class_name Drivable extends CharacterBody2D
@export var is_active = false
func _ready():
	add_to_group("Vehicles")
	$DrivingComponent.direction = rotation
	$DrivingComponent.is_active = is_active

func _physics_process(delta):
	velocity = $DrivingComponent.velocity
	rotation = $DrivingComponent.direction
	move_and_collide(velocity)
	handle_animation()
		
func handle_animation():
	pass
