extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await $Timer.timeout
	finished.emit()
	print("acabou")
