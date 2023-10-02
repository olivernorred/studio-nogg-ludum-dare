extends Person

signal interacted_with_vehicle(vehicle)


func check_vehicle():
	if $VehicleChecker.is_colliding() and $VehicleChecker.get_collider().is_in_group("Vehicles"):
		
		if Input.is_action_just_pressed("vehicle_interact"):
			interacted_with_vehicle.emit($VehicleChecker.get_collider())
			print("vehicle interact")

func handle_movement():
	var direction = Input.get_vector("left", "right", "up", "down")

	velocity = velocity.move_toward(direction*speed, acceleration)
	if velocity.length() > 0:
		rotation = velocity.angle()

func handle_animation():
	if velocity.length() > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
