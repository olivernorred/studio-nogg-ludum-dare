class_name SmartPathFollow2D extends PathFollow2D

@export var is_traveling = false
@export var speed = 1.0
@export var looping = false
var old_progress = 0

signal path_finished
signal path_started


func _ready():
	path_finished.emit()
	loop = looping

func _physics_process(delta):
	if is_traveling:
		progress += speed
		if old_progress == 0 and progress !=0:
			path_started.emit()
		old_progress = progress 

func _process(delta):
	if progress_ratio >= 1:
		print(progress_ratio)
		path_finished.emit()
		if !loop:
			is_traveling = false

func start_traveling():
	is_traveling = true
