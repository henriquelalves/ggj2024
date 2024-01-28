extends Control


func _ready():
	$Button.pressed.connect(_on_start_pressed, ConnectFlags.CONNECT_ONE_SHOT)
	$AnimationPlayer.play("default")
	$Label2.text = "%d pontos" % Session.last_score

func _on_start_pressed():
	$AnimationPlayer.play_backwards("default")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://game/main.tscn")
