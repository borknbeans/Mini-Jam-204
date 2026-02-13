extends Panel

@onready var dragging_texture: TextureRect = $"../DraggingTexture"

# The slot we are dragging from
var drag_from_slot: IngredientSlot = null

# Ingredient that is currently being dragged
var dragging_ingredient: Ingredient = null

# Slot which should be drawn as highlighted
var highlighted_slot: IngredientSlot = null

func _process(delta: float) -> void:
	if dragging_ingredient:
		dragging_texture.global_position = get_viewport().get_mouse_position() - dragging_texture.size * 0.5

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	_on_ingredient_slot_drag_end(drag_from_slot, highlighted_slot)

func _on_ingredient_slot_drag_start(drag_from: IngredientSlot) -> void:
	if drag_from.ingredient:
		drag_from_slot = drag_from
		dragging_ingredient = drag_from.ingredient
		drag_from.ingredient = null
		drag_from.update_ingredient()
		
		dragging_texture.texture = dragging_ingredient.icon
		dragging_texture.visible = true

func _on_ingredient_slot_drag_step(drag_from: IngredientSlot, drag_to: IngredientSlot) -> void:
	if not dragging_ingredient:
		return
		
	if highlighted_slot == drag_to:
		return
	
	if highlighted_slot:
		highlighted_slot.set_highlight(false);
		
	highlighted_slot = drag_to;
	highlighted_slot.set_highlight(true)

func _on_ingredient_slot_drag_end(drag_from: IngredientSlot, drag_to: IngredientSlot) -> void:
	if not dragging_ingredient:
		return
	
	if highlighted_slot:
		highlighted_slot.set_highlight(false)
		highlighted_slot = null
	
	if drag_from == drag_to:
		drag_to.ingredient = dragging_ingredient
		drag_to.update_ingredient()
	else:
		drag_from.ingredient = drag_to.ingredient
		drag_to.ingredient = dragging_ingredient;
		drag_to.update_ingredient()
		drag_from.update_ingredient()
		
	reset()
	
func reset() -> void:
	drag_from_slot = null
	dragging_ingredient = null
	dragging_texture.texture = null
	dragging_texture.visible = false
	
func return_item_to_original_slot() -> void:
	if highlighted_slot:
		highlighted_slot.set_highlight(false)
		highlighted_slot = null
		
	drag_from_slot.ingredient = dragging_ingredient
	drag_from_slot.update_ingredient()
	reset()
		
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			return_item_to_original_slot()
