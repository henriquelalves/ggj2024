extends AnimatedSprite3D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	position.z -= delta * 3
	
	if Input.is_anything_pressed():
		animation = "dodge"
		offset.y = -100.0
	else:
		animation = "default"
		offset.y = 0.0
