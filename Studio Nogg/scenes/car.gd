class_name Car extends Drivable


func _on_person_checker_area_entered(area):
	if can_be_selected:
		$SelectionIndicator.visible = true


func _on_person_checker_area_exited(area):
	$SelectionIndicator.visible = false
