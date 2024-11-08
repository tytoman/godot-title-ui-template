class_name TransitableControl
extends Control


## Relative position with respect to screen size.
@export var fade_on_transition: bool = true
@export var anim_direction: Vector2 = Vector2.ZERO
@export var anim_scale: Vector2 = Vector2.ONE
@export var anim_duration: float = 0.2
@export var anim_ease_type: Tween.EaseType = Tween.EASE_IN_OUT
@export var anim_trans_type: Tween.TransitionType = Tween.TRANS_SINE
@export var hide_when_start: bool = false
@export var relative_pivot_offset: Vector2 = Vector2(0.5, 0.5):
	set(value):
		pivot_offset = relative_pivot_offset * size

var _tween: Tween
var _appear_position: Vector2
var _appear_scale: Vector2
var _buttons: Array[BaseButton]

var _disappear_position: Vector2:
	get:
		return _appear_position + anim_direction * Vector2(get_window().size)
var _disappear_scale: Vector2:
	get:
		return anim_scale


func _ready() -> void:
	_appear_position = position
	_appear_scale = scale
	pivot_offset = relative_pivot_offset * size
	
	_find_buttons(self)
	
	if hide_when_start:
		hide()


func appear() -> void:
	if _tween != null:
		_tween.kill()
	
	_disable_buttons(false)
	show()
	modulate.a = 0.0
	
	position = _disappear_position
	scale = _disappear_scale
	
	_tween = get_tree().create_tween()
	_tween.set_ease(anim_ease_type)
	_tween.set_trans(anim_trans_type)
	_tween.set_parallel()
	if fade_on_transition:
		_tween.tween_property(self, "modulate:a", 1.0, anim_duration)
	_tween.tween_property(self, "position", _appear_position, anim_duration)
	_tween.tween_property(self, "scale", _appear_scale, anim_duration)
	
	await _tween.finished


func disappear() -> void:
	if _tween != null:
		_tween.kill()
	
	_disable_buttons(true)
	
	_tween = get_tree().create_tween()
	_tween.set_ease(anim_ease_type)
	_tween.set_trans(anim_trans_type)
	_tween.set_parallel()
	if fade_on_transition:
		_tween.tween_property(self, "modulate:a", 0.0, anim_duration)
	_tween.tween_property(self, "position", _disappear_position, anim_duration)
	_tween.tween_property(self, "scale", _disappear_scale, anim_duration)
	_tween.set_parallel(false)
	_tween.tween_callback(hide)
	
	await _tween.finished


func _find_buttons(node: Node) -> void:
	if node is BaseButton:
		_buttons.push_back(node)
	
	for child in node.get_children():
		_find_buttons(child)


func _disable_buttons(value: bool) -> void:
	for button in _buttons:
		button.disabled = value
