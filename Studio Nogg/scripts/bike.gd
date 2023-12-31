extends Drivable

@export var white_bike = false
var white_bike_texture = preload("res://WhiteBike.png")

func handle_sprite_change():
	if white_bike:
		$Sprite2D.texture = white_bike_texture
		

func handle_animation():

	
	if velocity.length() > 0:
		$AnimationPlayer.play("ride")
	else:
		$AnimationPlayer.play("idle")
	
	if $DrivingComponent.turn < 0:
		$AnimationPlayer.play("turn_left")
			
	elif $DrivingComponent.turn > 0:
		$AnimationPlayer.play("turn_right")
		
	if !is_active:
		$AnimationPlayer.play("empty")
