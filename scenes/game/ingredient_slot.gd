class_name IngredientSlot extends Panel

@onready var texture_rect: TextureRect = $TextureRect
@export var ingredient: Ingredient

signal drag_start(drag_from: IngredientSlot)
signal drag_step(drag_from: IngredientSlot, drag_to: IngredientSlot)
signal drag_end(drag_from: IngredientSlot, drag_to: IngredientSlot)

func update_ingredient() -> void:
	if not ingredient:
		texture_rect.texture = null
	else:
		texture_rect.texture = ingredient.icon
		
func set_highlight(is_highlighted: bool) -> void:
	if (is_highlighted):
		const width = 1
		var style := StyleBoxFlat.new()
		style.border_color = Color.WHITE
		style.border_width_left = width
		style.border_width_top = width
		style.border_width_right = width
		style.border_width_bottom = width
		style.bg_color = Color.TRANSPARENT  # keep original look

		add_theme_stylebox_override("panel", style)
	else:
		remove_theme_stylebox_override("panel")
		
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
