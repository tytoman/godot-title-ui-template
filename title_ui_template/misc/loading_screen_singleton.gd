class_name LoadingScreenSingleton
extends CanvasLayer


signal progress_updated(progress: float)

@export var transition_panel: Control
@export var anim_duration: float = 0.4
@export var anim_ease_type: Tween.EaseType = Tween.EASE_IN_OUT
@export var anim_trans_type: Tween.TransitionType = Tween.TRANS_LINEAR

var loading_progress: float:
	set(value):
		if not is_equal_approx(value, loading_progress):
			loading_progress = value
			progress_updated.emit(value)

var _tween: Tween
var _transition_material: ShaderMaterial


func _ready() -> void:
	_transition_material = transition_panel.material
	disappear()


func delay(callable: Callable, duration: float) -> void:
	await get_tree().create_timer(duration).timeout
	callable.call()


func appear() -> void:
	if _tween != null:
		_tween.kill()
	
	show()
	_set_progress(1.0)
	_transition_material.set_shader_parameter("inverse", false)
	
	_tween = get_tree().create_tween()
	_tween.set_ease(anim_ease_type)
	_tween.set_trans(anim_trans_type)
	_tween.tween_method(_set_progress, 1.0, 0.0, anim_duration)
	
	await _tween.finished


func disappear() -> void:
	if _tween != null:
		_tween.kill()
	
	show()
	_set_progress(0.0)
	_transition_material.set_shader_parameter("inverse", true)
	
	_tween = get_tree().create_tween()
	_tween.set_ease(anim_ease_type)
	_tween.set_trans(anim_trans_type)
	_tween.tween_method(_set_progress, 0.0, 1.0, anim_duration)
	_tween.tween_callback(hide)
	
	await _tween.finished


func _set_progress(value: float) -> void:
	_transition_material.set_shader_parameter("progress", value)
