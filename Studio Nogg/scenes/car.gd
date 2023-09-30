extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	$DrivingComponent.direction = rotation

func _physics_process(delta):
	velocity = $DrivingComponent.velocity
	rotation = $DrivingComponent.direction
	move_and_collide(velocity)
