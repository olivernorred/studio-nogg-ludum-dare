class_name DrivingComponent extends Node2D
var is_active = false

@export var can_reverse = true;
@export var forward_speed = 4.0
@export var reverse_speed = 2.0
var speed = 0
@export var turn_speed = 0.05
@export var acceleration = 0.5
var gear = 0

var turn  = 0
var direction = 0

var velocity = Vector2(0,0)
func _physics_process(delta):
	if is_active:
		gear = Input.get_axis("down", "up") if can_reverse else Input.get_action_strength("up")
		
		if gear > 0:
			speed = forward_speed
		elif gear < 0:
			speed = reverse_speed
		
		turn = Input.get_axis("left", "right")
		if velocity.length() > 0:
			direction += turn * turn_speed * gear * speed/forward_speed
		else:
			turn = 0
		
		velocity = velocity.move_toward(Vector2.from_angle(direction) * speed * gear, acceleration)
