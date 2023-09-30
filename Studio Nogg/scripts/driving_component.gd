class_name DrivingComponent extends Node2D
@export var active = false;
@export var can_reverse = true;

@export var speed = 300.0
@export var turn_speed = 0.05
# Get the gravity from the project settings to be synced with RigidBody nodes.

var turn  = 0
var direction = 0

var velocity = Vector2(0,0)
func _physics_process(delta):


	if active:
		var gear = Input.get_axis("ui_down", "ui_up") if can_reverse else Input.get_action_strength("ui_up")
		
		if velocity.length() > speed/2:
			turn = Input.get_axis("ui_left", "ui_right")
			direction += turn * turn_speed
		else:
			turn = 0
		
		velocity = Vector2.from_angle(direction) * speed * gear
