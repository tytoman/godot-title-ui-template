class_name QuitButton
extends Button


func _ready() -> void:
	pressed.connect(get_tree().quit)
