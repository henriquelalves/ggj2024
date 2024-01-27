extends Microgame


# Called when the node enters the scene tree for the first time.
func _microgame_ready():
	var windows = $AllWindows.get_children()
	var max_windows = windows.size() - randi_range(0,2)
	for i in max_windows:
		var window = windows[i]
		window.position = window.position + Vector2(randf_range(-100, 100), randf_range(-100,100))
		window.show()
		$Timer.start(0.1)
		await $Timer.timeout


func _on_send_button_button_down():
	%TextBoxMessage.hide()
	%ChatMessage.show()
	finished.emit(true)
