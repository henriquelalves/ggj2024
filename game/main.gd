extends Node2D

const MICROGAMES = [preload("res://game/microgames/flowers_delivery/flowers_delivery.tscn")]

@onready var transition: Transition = %Transition
@onready var microgame_viewport = %MicrogameViewport
@onready var microgame_subviewport = %MicrogameSubViewport

var _current_microgame: Microgame


func _ready() -> void:
	remove_child(microgame_viewport)
	transition.microgame_viewport_container.add_child(microgame_viewport)
	microgame_viewport.offset_bottom = 0
	microgame_viewport.offset_left = 0
	microgame_viewport.offset_right = 0
	microgame_viewport.offset_top = 0
	
	while true:
		if _current_microgame != null:
			_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
		
		transition.show_win_animation()
		
		await transition.microgame_viewport_hidden
		
		if _current_microgame != null:
			_current_microgame.queue_free()
		
		_current_microgame = MICROGAMES[0].instantiate()
		microgame_subviewport.add_child(_current_microgame)
		_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
	
		await transition.finished
		_current_microgame.process_mode = Node.PROCESS_MODE_INHERIT
		
		await _current_microgame.finished
