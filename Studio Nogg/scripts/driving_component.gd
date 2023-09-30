class_name DrivingComponent extends Node2D
var is_active = false

@export var can_reverse = true;
@export var speed = 5.0
@export var turn_speed = 0.05
@export var acceleration = 0.5

var turn  = 0
var direction = 0

var velocity = Vector2(0,0)
func _physics_process(delta):


	if is_active:
		var gear = Input.get_axis("ui_down", "ui_up") if can_reverse else Input.get_action_strength("ui_up")
		
		if velocity.length() > 0:
			turn = Input.get_axis("ui_left", "ui_right")
			direction += turn * turn_speed
		else:
			turn = 0
		
		velocity = velocity.move_toward(Vector2.from_angle(direction) * speed * gear, acceleration)
