class_name Microgame
extends Node

const MICROGAME_TIMER = 5.0

enum MICROGAME_CONTROL {HEAD_ON_KEYBOARD, INVERTED_HAND, ONLY_PINKY}

@export var microgame_name = ""
@export var microgame_control: MICROGAME_CONTROL
@export var instructions = ""
@export var win_on_timeout = true

signal finished(won)


func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(MICROGAME_TIMER)
	
	timer.timeout.connect(func():
		finished.emit(win_on_timeout)
	)
	
	_microgame_ready()


func _microgame_ready():
	pass
