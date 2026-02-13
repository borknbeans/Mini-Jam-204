class_name IngredientSlot extends Panel

@onready var texture_panel: IngredientTexturePanel = $TexturePanel
@onready var texture_rect: TextureRect = $TexturePanel/TextureRect
@export var ingredient: Ingredient
@export var is_static: bool = false

signal drag_start(drag_from: IngredientSlot)
signal drag_step(drag_from: IngredientSlot, drag_to: IngredientSlot)
signal drag_end(drag_from: IngredientSlot, drag_to: IngredientSlot)

func update_ingredient() -> void:
	if not ingredient:
		texture_rect.texture = null
	else:
		texture_rect.texture = ingredient.icon
		
func set_highlight(is_highlighted: bool) -> void:
	texture_panel.set_highlight(is_highlighted)
		
func _ready() -> void:
	update_ingredient()

func _get_drag_data(at_position: Vector2) -> Variant:
	drag_start.emit(self)
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	drag_step.emit(data, self)
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	drag_end.emit(data, self)
	
func set_ingredient(new_ingredient: Ingredient) -> void:
	if is_static:
		return
		
	ingredient = new_ingredient
	update_ingredient()
