extends Node2D

var MICROGAMES = [
	preload("res://game/microgames/flowers_delivery/flowers_delivery.tscn"),
	#preload("res://game/microgames/heart_break/heart_break.tscn"),
	#preload("res://game/microgames/find_window/find_window.tscn"),
	#preload("res://game/microgames/baseball_kiss/baseball_kiss.tscn")
	]

@onready var transition: Transition = %Transition
@onready var microgame_viewport = %MicrogameViewport
@onready var microgame_subviewport = %MicrogameSubViewport
@onready var microgame_timer: Timer = %MicrogameTimer
@onready var instruction_popup: InstructionPopup = %InstructionPopup

var _current_microgame: Microgame
var _starting = true
var _won_last_microgame = false
var _microgame_count = 1
var _microgame_idx = 0
var lives = 4

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
			
			if not _won_last_microgame:
				await get_tree().create_timer(0.5).timeout 
				transition.lose_life()
				lives -= 1
				
				if lives == 0:
					await get_tree().create_timer(0.5).timeout 
					%FadeAnimationPlayer.play_backwards("fade_in")
					await %FadeAnimationPlayer.animation_finished
					get_tree().change_scene_to_file("res://game/menu.tscn")
					
		_current_microgame = MICROGAMES[_microgame_idx].instantiate()
		_microgame_idx = (_microgame_idx + 1) % MICROGAMES.size()
		if _microgame_idx == 0:
			MICROGAMES.shuffle()
		
		microgame_subviewport.add_child(_current_microgame)
		_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
	
		await transition.play_microgame_count(_microgame_count)
		
		if not Session.shown_types.has(_current_microgame.microgame_control):
			await instruction_popup.play_instruction(_current_microgame.microgame_control)
			Session.shown_types[_current_microgame.microgame_control] = true
		
		var instruction_resource = instruction_popup.get_instruction(_current_microgame.microgame_control)
		await transition.show_instruction(instruction_resource)
		
		%MicrogameInstructionLabel.show_instruction(_current_microgame.instructions)
		
		await transition.microgame_fade_in()
		
		%MicrogameTvTimer.play()
		_current_microgame.process_mode = Node.PROCESS_MODE_INHERIT
		
		_won_last_microgame = await _current_microgame.finished
		_current_microgame.process_mode = Node.PROCESS_MODE_DISABLED
		
		if _current_microgame.get_time_left() > 0.001:
			%MicrogameTvTimer.finish()
		
		await get_tree().create_timer(0.5).timeout
		
		_starting = false
		_microgame_count += 1
		Engine.time_scale = 1 + (_microgame_count * 0.05)
