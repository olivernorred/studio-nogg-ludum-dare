extends Drivable

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
	
