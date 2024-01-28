@tool
extends Node2D

@onready var animated_sprite: AnimatedSprite2D = %CharacterAnimatedSprite
var _sprite_frames: SpriteFrames

@export var sprite_frames: SpriteFrames :
	set(v):
		_sprite_frames = v
		if not is_node_ready():
			await ready
		animated_sprite.sprite_frames = _sprite_frames
	get:
		return _sprite_frames


func _reset_animation():
	animated_sprite.animation = "default"


func play_puff():
	$Explosion.show()
	$Explosion.play("default")
	$CharacterAnimatedSprite.hide()


func play_happy():
	animated_sprite.animation = "happy"
	var tween = create_tween()
	tween.tween_property(animated_sprite, "scale", Vector2.ONE, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC).from(Vector2(1.3, 0.8))
	tween.tween_callback(_reset_animation).set_delay(0.5)


func play_mad():
	animated_sprite.animation = "mad"
	var tween = create_tween()
	tween.tween_property(animated_sprite, "scale", Vector2.ONE, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).from(Vector2(1.2, 0.8))
	tween.tween_callback(_reset_animation).set_delay(0.5)
