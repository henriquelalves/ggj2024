class_name Microgame
extends Node

const MICROGAME_TIMER = 5.0

enum MICROGAME_CONTROL {HEAD_ON_KEYBOARD, INVERTED_HAND, ONLY_PINKY}

@export var microgame_name = ""
@export var microgame_control: MICROGAME_CONTROL
@export var instructions = ""
@export var win_on_timeout = true

var _timer: Timer

signal finished(won)

func get_time_left():
	return _timer.time_left


func _ready():
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.start(MICROGAME_TIMER)
	
	_timer.timeout.connect(func():
		finished.emit(win_on_timeout)
	)
	
	_microgame_ready()


func _microgame_ready():
	pass
