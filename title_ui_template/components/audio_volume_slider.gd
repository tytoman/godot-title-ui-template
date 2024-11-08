class_name AudioVolumeSlider
extends Slider


@export var bus_name: String = "Master"

@onready var _bus_idx := AudioServer.get_bus_index(bus_name)


func _ready() -> void:
	min_value = 0.0
	max_value = 1.0
	step = 0.0
	value_changed.connect(_on_sound_volume_slider_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus_idx))


func _on_sound_volume_slider_changed(volume: float) -> void:
	AudioServer.set_bus_volume_db(_bus_idx, linear_to_db(volume))
	AudioServer.set_bus_mute(_bus_idx, is_zero_approx(volume))
