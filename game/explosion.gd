extends AnimatedSprite2D


func explode():
	show()
	frame = 0
	play("default")
	$AudioStreamPlayer.play()
