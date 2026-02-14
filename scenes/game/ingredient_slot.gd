class_name IngredientSlot extends Panel

@onready var texture_panel: IngredientTexturePanel = $TexturePanel
@onready var texture_rect: TextureRect = $TexturePanel/TextureRect
@onready var count_selection: VBoxContainer = $CountSelection
@export var ingredient: Ingredient
@export var count: int = 1
@export var is_static: bool = false

var count_button_group: ButtonGroup

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
	if is_static:
		count_selection.visible = false
		
	# Connect button group signal
	var count_button: BaseButton = count_selection.get_child(0)
	count_button_group = count_button.button_group
	count_button_group.connect("pressed", _on_count_changed)
		
	update_ingredient()

func _input(event):
	if not get_global_rect().has_point(get_viewport().get_mouse_position()):
		return
	
	if event is InputEventMouseButton:
		if not event.is_released():
			return
			
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			set_count(min(count + 1, 3))
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			set_count(max(count - 1, 1))
	
func _on_count_changed(button: BaseButton) -> void:
	count = int(button.text)
	
func set_count(new_count) -> void:
	if new_count == count:
		return
		
	count = new_count
	count_button_group.get_pressed_button().set_pressed_no_signal(false)
	var button = count_button_group.get_buttons()[3 - count]
	button.set_pressed_no_signal(true)

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
