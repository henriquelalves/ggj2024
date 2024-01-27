class_name Transition
extends Node2D

@export var speed_scale = 1.0

signal finished_animation

@onready var animation_player = %AnimationPlayer
@onready var microgame_viewport_container = %MicrogameViewportContainer

var _lives = 0
var _characters = []


func _ready() -> void:
	animation_player.speed_scale = speed_scale
	_characters = %Characters.get_children()


func reset() -> void:
	animation_player.play("RESET")
	for c in _characters:
		c._reset_animation()


func microgame_fade_out():
	animation_player.play("microgame_fade_out")
	await animation_player.animation_finished


func microgame_fade_in():
	animation_player.play_backwards("microgame_fade_out")
	await animation_player.animation_finished


func play_microgame_count(count: int):
	%MicrogameCountLabel.text = "%03d" % count
	animation_player.play("show_microgame_count")
	await animation_player.animation_finished


func play_result_animation(won : bool) -> void:
	for c in _characters:
		if (won):
			c.play_happy()
		else:
			c.play_mad()
	await get_tree().create_timer(0.5).timeout
