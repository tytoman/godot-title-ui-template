class_name LoadSceneButton
extends SoundPlayButton


@export_file("*.tscn") var scene_path: String


func _ready() -> void:
	super._ready()
	pressed.connect(_load_scene)


func _load_scene() -> void:
	LoadingScreen.loading_progress = 0.0
	ResourceLoader.load_threaded_request(scene_path)
	
	await LoadingScreen.appear()
	
	# Wait loading and update progress.
	var status := ResourceLoader.load_threaded_get_status(scene_path)
	var progress: Array[float] = [0.0]
	while status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await get_tree().process_frame
		status = ResourceLoader.load_threaded_get_status(scene_path, progress)
		LoadingScreen.loading_progress = progress.front()
	
	if status != ResourceLoader.THREAD_LOAD_LOADED:
		LoadingScreen.disappear()
		push_error("Cannot load the scene ", scene_path)
		return
	
	LoadingScreen.loading_progress = 1.0
	var res := ResourceLoader.load_threaded_get(scene_path)
	var err := get_tree().change_scene_to_packed(res)
	
	if err != OK:
		LoadingScreen.disappear()
		push_error("Cannot change the scene ", scene_path ,": ", error_string(err))
		return
	
	LoadingScreen.disappear()
