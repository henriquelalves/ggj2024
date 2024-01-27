extends Node2D

const MICROGAMES = [preload("res://game/microgames/flowers_delivery/flowers_delivery.tscn")]

@onready var transition: Transition = %Transition
@onready var microgame_viewport = %MicrogameViewport
@onready var microgame_subviewport = %MicrogameSubViewport
@onready var microgame_timer: Timer = %MicrogameTimer

var _current_microgame: Microgame
var _starting = true
var _won_last_microgame = false
var _microgame_count = 1


func _ready() -> void:
	remove_child(microgame_viewport)
	transition.microgame_viewport_container.add_child(microgame_viewport)
	microgame_viewport.offset_bottom = 0
	microgame_viewport.offset_left = 0
	microgame_viewport.offset_right = 0
	microgame_viewport.offset_top = 0
	
	transition.reset()
	
	while true:
		if _current_microgame != null:
			_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
			
			await transition.microgame_fade_out()
			_current_microgame.queue_free()
			
			await transition.play_result_animation(_won_last_microgame)
		
		_current_microgame = MICROGAMES[0].instantiate()
		microgame_subviewport.add_child(_current_microgame)
		_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
	
		await transition.play_microgame_count(_microgame_count)
		
		await transition.microgame_fade_in()
		
		_current_microgame.process_mode = Node.PROCESS_MODE_INHERIT
		
		_won_last_microgame = await _current_microgame.finished
		
		_starting = false
		_microgame_count += 1
