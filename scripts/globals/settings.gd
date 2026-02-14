extends Node

var master_volume: float = 1.0: set = _set_master_volume
var sound_effects_volume: float = 1.0: set = _set_sound_effects_volume
var music_volume: float = 1.0: set = _set_music_volume

#func _ready() -> void:
	#Input.set_custom_mouse_cursor(load("res://textures/cursor/hand_point.png"))
	#Input.set_custom_mouse_cursor(load("res://textures/cursor/hand_closed.png"), Input.CURSOR_CAN_DROP)
	#Input.set_custom_mouse_cursor(load("res://textures/cursor/hand_closed.png"), Input.CURSOR_WAIT)


func _set_master_volume(value: float) -> void:
	master_volume = clampf(value, 0.0, 1.0)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), master_volume)

func _set_sound_effects_volume(value: float) -> void:
	sound_effects_volume = clampf(value, 0.0, 1.0)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Sound Effects"), sound_effects_volume)

func _set_music_volume(value: float) -> void:
	music_volume = clampf(value, 0.0, 1.0)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), music_volume)
