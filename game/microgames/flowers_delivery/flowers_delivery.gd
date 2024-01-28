extends Microgame


# Called when the node enters the scene tree for the first time.
func _microgame_ready() -> void:
	$Player.died.connect(_on_died)


func _on_died():
	finished.emit(false)
