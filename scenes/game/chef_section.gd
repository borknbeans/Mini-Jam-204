extends Panel

# Texture used to display dragged item on cursor
@onready var dragging_texture: TextureRect = $"../DraggingTexture"

# Component which contains recipe ingredient slots
@onready var recipe_slot_container: HBoxContainer = $RecipeSection/MarginContainer/HBoxContainer

# The slot we are dragging from
var drag_from_slot: IngredientSlot = null

# Ingredient that is currently being dragged
var dragging_ingredient: Ingredient = null

# Slot which should be drawn as highlighted
var highlighted_slot: IngredientSlot = null

func get_current_recipe() -> Recipe:
	var recipe: Recipe = Recipe.new()
	
	var ingredient_slots = recipe_slot_container.get_children()
	for ingredient_slot: IngredientSlot in ingredient_slots:
		recipe.add_ingredient(ingredient_slot.ingredient, ingredient_slot.count)
	
	return recipe

func _process(delta: float) -> void:
	if not dragging_ingredient:
		return
	
	dragging_texture.global_position = get_viewport().get_mouse_position() - dragging_texture.size * 0.5
	
	# Code for snapping the dragging texture to the nearest IngredientSlot
	return
	if not highlighted_slot or highlighted_slot.is_static:
		dragging_texture.global_position = get_viewport().get_mouse_position() - dragging_texture.size * 0.5
	else:
		var highlight_center = highlighted_slot.global_position
		highlight_center += highlighted_slot.size * 0.5
		dragging_texture.global_position = highlight_center - dragging_texture.size * 0.5

# Drop ingredient on background component
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if not dragging_ingredient:
		return true
	
	_on_ingredient_slot_drag_step(drag_from_slot, null);
	
	return true
	
# Drop ingredient on background component
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if not dragging_ingredient:
		return
	
	if highlighted_slot:
		_on_ingredient_slot_drag_end(drag_from_slot, highlighted_slot)
	else:
		return_item_to_original_slot()

# IngredientSlot started dragging
func _on_ingredient_slot_drag_start(drag_from: IngredientSlot) -> void:
	if drag_from.ingredient:
		drag_from_slot = drag_from
		dragging_ingredient = drag_from.ingredient
		drag_from.set_ingredient(null)
		
		dragging_texture.texture = dragging_ingredient.icon
		dragging_texture.visible = true

# IngredientSlot is being dragged dragging
func _on_ingredient_slot_drag_step(drag_from: IngredientSlot, drag_to: IngredientSlot) -> void:
	if not dragging_ingredient:
		return
		
	if highlighted_slot == drag_to:
		return
	
	if highlighted_slot:
		highlighted_slot.set_highlight(false);
		
	highlighted_slot = drag_to;
	if highlighted_slot:
		highlighted_slot.set_highlight(true)

# IngredientSlot finished being dragged
func _on_ingredient_slot_drag_end(drag_from: IngredientSlot, drag_to: IngredientSlot) -> void:
	if not dragging_ingredient:
		return
	
	if not drag_to.is_static:
		if drag_from == drag_to:
			drag_from.set_ingredient(dragging_ingredient)
		else:
			drag_from.set_ingredient(drag_to.ingredient)
			drag_to.set_ingredient(dragging_ingredient)
		
	reset()
	
# Reset state after dragging is finished
func reset() -> void:
	if highlighted_slot:
		highlighted_slot.set_highlight(false)
		highlighted_slot = null
	
	drag_from_slot = null
	dragging_ingredient = null
	dragging_texture.texture = null
	dragging_texture.visible = false
	
func return_item_to_original_slot() -> void:
	drag_from_slot.set_ingredient(dragging_ingredient)
	reset()
		
# Intercept drag end notification to check for unsuccessful drags
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			return_item_to_original_slot()
