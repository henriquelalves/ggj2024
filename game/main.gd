extends Node2D

var MICROGAMES = [
	preload("res://game/microgames/flowers_delivery/flowers_delivery.tscn"),
	preload("res://game/microgames/heart_break/heart_break.tscn"),
	preload("res://game/microgames/find_window/find_window.tscn"),
	preload("res://game/microgames/baseball_kiss/baseball_kiss.tscn")
	]

@onready var transition: Transition = %Transition
@onready var microgame_viewport = %MicrogameViewport
@onready var microgame_subviewport = %MicrogameSubViewport
@onready var microgame_timer: Timer = %MicrogameTimer

var _current_microgame: Microgame
var _starting = true
var _won_last_microgame = false
var _microgame_count = 1
var _microgame_idx = 0


func _ready() -> void:
	randomize()
	
	MICROGAMES.shuffle()
	
	%FadeAnimationPlayer.play("fade_in")
	transition.reset()
	transition.microgame_fade_out()
	await %FadeAnimationPlayer.animation_finished
	
	remove_child(microgame_viewport)
	transition.microgame_viewport_container.add_child(microgame_viewport)
	microgame_viewport.offset_bottom = 0
	microgame_viewport.offset_left = 0
	microgame_viewport.offset_right = 0
	microgame_viewport.offset_top = 0
	
	while true:
		if _current_microgame != null:
			await transition.microgame_fade_out()
			_current_microgame.queue_free()
			
			await transition.play_result_animation(_won_last_microgame)
		
		_current_microgame = MICROGAMES[_microgame_idx].instantiate()
		_microgame_idx = (_microgame_idx + 1) % MICROGAMES.size()
		if _microgame_idx == 0:
			MICROGAMES.shuffle()
		
		microgame_subviewport.add_child(_current_microgame)
		_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
	
		await transition.play_microgame_count(_microgame_count)
		
		await transition.microgame_fade_in()
		
		_current_microgame.process_mode = Node.PROCESS_MODE_INHERIT
		
		_won_last_microgame = await _current_microgame.finished
		_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
		
		await get_tree().create_timer(0.5).timeout
		
		_starting = false
		_microgame_count += 1
		Engine.time_scale = 1 + (_microgame_count * 0.05)
