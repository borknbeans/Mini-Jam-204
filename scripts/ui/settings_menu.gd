class_name SettingsMenu extends Control

signal back_pressed

@onready var back_button: Button = %BackButton
@onready var quit_button: Button = %QuitButton

@onready var master_volume_slider: HSlider = %MasterVolumeSlider
@onready var sound_effects_volume_slider: HSlider = %SoundEffectsVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider

@onready var master_volume_label: Label = %ActualMasterVolumeLabel
@onready var sound_effects_volume_label: Label = %ActualSoundEffectsVolumeLabel
@onready var music_volume_label: Label = %ActualMusicVolumeLabel

@export var show_quit_to_menu_button: bool = false
@export var scene_to_quit_to: PackedScene = preload("res://scenes/ui/main_menu.tscn")

func _ready() -> void:
	_sync_audio_values()
	
	quit_button.visible = show_quit_to_menu_button

func _sync_audio_values() -> void:
	master_volume_slider.value        = Settings.master_volume
	sound_effects_volume_slider.value = Settings.sound_effects_volume
	music_volume_slider.value         = Settings.music_volume
	
	master_volume_label.text          = _format_text(Settings.master_volume)
	sound_effects_volume_label.text   = _format_text(Settings.sound_effects_volume)
	music_volume_label.text           = _format_text(Settings.music_volume)

func _on_back_button_pressed() -> void:
	back_pressed.emit()
	hide()

func _on_master_volume_changed(value: float) -> void:
	Settings.master_volume = value
	master_volume_label.text = _format_text(value)

func _on_sound_effects_volume_changed(value: float) -> void:
	Settings.sound_effects_volume = value
	sound_effects_volume_label.text = _format_text(value)

func _on_music_volume_changed(value: float) -> void:
	Settings.music_volume = value
	music_volume_label.text = _format_text(value)

func _format_text(value: float) -> String:
	return str(int(value * 100)) + "%"

func _on_visibility_changed() -> void:
	if visible:
		_sync_audio_values()

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_packed(scene_to_quit_to)
