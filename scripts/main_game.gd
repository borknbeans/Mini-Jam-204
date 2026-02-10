extends Node2D

@onready var settings_menu: SettingsMenu = $CanvasLayer/SettingsMenu


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		settings_menu.visible = !settings_menu.visible
