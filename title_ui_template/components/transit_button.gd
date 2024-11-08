class_name TransitButton
extends SoundPlayButton


@export var from: TransitableControl
@export var to: TransitableControl
@export var transit_interval: float = 0.1


func _ready() -> void:
	super._ready()
	pressed.connect(_transit)


func _transit() -> void:
	if from != null:
		from.disappear()
	
	if transit_interval > 0.0:
		await get_tree().create_timer(transit_interval).timeout
	
	if to != null:
		to.appear()
