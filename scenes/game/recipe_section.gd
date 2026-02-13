extends Panel

func _on_ingredient_slot_drag_start(drag_from: IngredientSlot) -> void:
	pass

func _on_ingredient_slot_drag_step(drag_from: IngredientSlot, drag_to: IngredientSlot) -> void:
	pass

func _on_ingredient_slot_drag_end(drag_from: IngredientSlot, drag_to: IngredientSlot) -> void:
	if (drag_from == drag_to):
		return;
	
	if (drag_from.ingredient):
		var temp = drag_to.ingredient;
		drag_to.ingredient = drag_from.ingredient;
		drag_from.ingredient = temp;
		drag_to.update_ingredient()
		drag_from.update_ingredient()
