extends Node2D

@export var number_sprites: Array[Texture2D]

var sprite_idx = 0
var timer = 0.0
var _playing = false

func play():
	sprite_idx = 0
	timer = 0.0
	show()
	%TVSprite.show()
	%NumberSprite.show()
	%Explosion.hide()
	$AnimationPlayer.play("enter")
	($AnimationPlayer as AnimationPlayer).seek(0, true)
	_playing = true


func finish():
	_playing = false
	$AnimationPlayer.play_backwards("enter")


func _physics_process(delta):
	if not _playing:
		return
	
	timer += delta
	var idx = clamp(int(timer), 0, 4)
	%NumberSprite.texture = number_sprites[idx]

	if timer > 5.0:
		_playing = false
		%TVSprite.hide()
		%NumberSprite.hide()
		%Explosion.explode()
		await get_tree().create_timer(0.6).timeout
		hide()
