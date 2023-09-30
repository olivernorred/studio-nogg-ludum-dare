extends RigidBody2D
@export var node_to_follow : Node
@onready var vector_between_hitches = node_to_follow.position - position
@onready var max_distance_to_horse = vector_between_hitches.length()
const FRICTION = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var perpendicular_velocity_component = linear_velocity.project(Vector2.from_angle(rotation)*FRICTION)
	apply_central_force(-100*perpendicular_velocity_component)
