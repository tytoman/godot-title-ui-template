class_name SoundPlayButton
extends Button


@export var audio_player: AudioStreamPlayer


func _ready() -> void:
	pressed.connect(_play_sound)


func _play_sound() -> void:
	if audio_player != null:
		audio_player.play()
