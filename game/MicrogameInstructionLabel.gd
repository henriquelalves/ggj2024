extends Label


func show_instruction(instruction):
	text = instruction
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.1).set_delay(2)
