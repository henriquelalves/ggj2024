class_name InstructionPopup
extends Control

@export var instructions: Array[InstructionResource]

func play_instruction(type: Microgame.MICROGAME_CONTROL):
	var instruction: InstructionResource = get_instruction(type)
	
	%TextureZoeira.texture = instruction.texture_zoeira
	%TextureInstruction.texture = instruction.texture_instruction
	%LabelTitle.text = instruction.title
	%Label1.text = instruction.label_1
	%Label2.text = instruction.label_2
	
	$AnimationPlayer.play("start")
	await $AnimationPlayer.animation_finished


func get_instruction(type: Microgame.MICROGAME_CONTROL) -> InstructionResource:
	for instruction in instructions:
		print(instruction.type)
		if instruction.type == type:
			return instruction
	return null
