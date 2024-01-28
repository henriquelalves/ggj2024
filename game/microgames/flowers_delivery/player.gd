extends AnimatedSprite3D

signal died
var _died = false


func _process(delta: float) -> void:
	if not _died:
		position.z -= delta * 3
		
		if Input.is_anything_pressed():
			animation = "dodge"
			offset.y = -100.0
		else:
			animation = "default"
			offset.y = 0.0
	
		if ($Area3D as Area3D).has_overlapping_areas():
			if animation == "default":
				_died = true
				died.emit()
