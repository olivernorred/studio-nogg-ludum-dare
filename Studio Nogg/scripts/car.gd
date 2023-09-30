extends CharacterBody2D
@export var active = false;

const SPEED = 300.0
const TURN_SPEED = 0.05
# Get the gravity from the project settings to be synced with RigidBody nodes.

var turn  = 0
var direction = 0
func _physics_process(delta):


	if active:
		var gear = Input.get_axis("ui_down", "ui_up")
		if velocity.length() > SPEED/2:
			turn = Input.get_axis("ui_left", "ui_right")
			rotation += turn * TURN_SPEED
		else:
			turn = 0
		

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = rotation
		velocity = Vector2.from_angle(direction) * SPEED * gear

		move_and_collide(velocity*delta)


func _on_click_checker_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		active = !active
