extends Node

## Plays an existing audio stream player with the option to randomly shift the pitch
## to add a slight variety to the audio
func play(audio_stream: AudioStreamPlayer, random_pitch: bool = false) -> void:
	if random_pitch:
		audio_stream.pitch_scale = randf_range(0.8, 1.2)
	audio_stream.play()
