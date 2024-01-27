extends Microgame


# Called when the node enters the scene tree for the first time.
func _microgame_ready() -> void:
	await $Timer.timeout
	finished.emit(true if randf() < 0.5 else false)
