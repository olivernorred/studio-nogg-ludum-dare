extends Person

signal interacted_with_vehicle(vehicle)

func check_vehicle():
	if $VehicleChecker.is_colliding() and $VehicleChecker.get_collider().is_in_group("Vehicles"):
		if Input.is_action_just_pressed("vehicle_interact"):
#			$VehicleChecker.get_collider().toggle_is_active()
			interacted_with_vehicle.emit($VehicleChecker.get_collider())
			print("vehicle interact")

func handle_animation():
	if velocity.length() > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
