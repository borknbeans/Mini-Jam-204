extends Control

@export var game_scene: PackedScene

@onready var main_menu_container: CenterContainer = $MainMenuContainer
@onready var settings_menu: SettingsMenu = $SettingsMenu

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_settings_button_pressed() -> void:
	main_menu_container.hide()
	settings_menu.show()

func _on_settings_menu_back_pressed() -> void:
	settings_menu.hide()
	main_menu_container.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
