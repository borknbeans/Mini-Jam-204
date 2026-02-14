extends Node2D

@onready var settings_menu: SettingsMenu = $CanvasLayer/SettingsMenu
@onready var drink_manager: DrinkManager = $DrinkManager


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		settings_menu.visible = !settings_menu.visible

func _ready() -> void:
	drink_manager.set_new_recipe(5)
