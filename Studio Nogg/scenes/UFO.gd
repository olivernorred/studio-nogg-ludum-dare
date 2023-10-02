extends Car

func handle_animation():
	if velocity.length() > 0:
		$AnimationPlayer.play("go")
	else:
		$AnimationPlayer.play("idle")
		
