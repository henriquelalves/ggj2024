class_name Transition
extends Node2D

@export var speed_scale = 1.0

@onready var animation_player = %AnimationPlayer
@onready var microgame_viewport_container = %MicrogameViewportContainer

signal finished
signal microgame_viewport_hidden


func _ready() -> void:
	animation_player.speed_scale = speed_scale


func _emit_microgame_viewport_hidden() -> void:
	microgame_viewport_hidden.emit()


func show_win_animation():
	animation_player.play("win_transition")
	await animation_player.animation_finished
	finished.emit()
