extends Line2D

@export var pointAAttach : Node
@export var pointBAttach : Node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	points[0] = pointAAttach.position
	points[1] = pointBAttach.position
