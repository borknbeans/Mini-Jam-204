extends Panel

func _on_ingredient_slot_drag_start() -> void:
	print("drag_start")

func _on_ingredient_slot_drag_step() -> void:
	print("drag_step")

func _on_ingredient_slot_drag_end(drag_from: Panel, drag_to: Panel) -> void:
	print("drag_end")
	print(drag_from)
	print(drag_to)
