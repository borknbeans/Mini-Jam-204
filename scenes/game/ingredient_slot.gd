extends Panel

signal drag_start
signal drag_step
signal drag_end(drag_from: Panel, drag_to: Panel)

func _get_drag_data(at_position: Vector2) -> Variant:
	drag_start.emit()
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	drag_step.emit()
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	drag_end.emit(data, self)
