class_name LoadingProgressBar
extends Slider


@export var loading_screen: LoadingScreenSingleton


func _ready() -> void:
	loading_screen.progress_updated.connect(_update_bar)


func _update_bar(progress: float) -> void:
	value = progress
