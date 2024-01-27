extends Microgame


func _on_player_heart_body_entered(body):
	if body is Spiky:
		disable_player()
		finished.emit(false)


func disable_player():
	$PlayerHeart.get_node("AnimatedSprite2D").play("death")
	$PlayerHeart.playerControl = false

