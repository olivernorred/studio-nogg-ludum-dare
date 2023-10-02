class_name FadingLabel extends Label

const OPACITY_DECLINE_RATE = 0.01
var font
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self_modulate.a -= OPACITY_DECLINE_RATE
	if self_modulate.a < 0:
		queue_free()
