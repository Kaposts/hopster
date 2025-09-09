@tool
extends State

var player: Player

func _on_enter(args):
	player = target
	print('state: Idle')
	change_state("Run")

func _on_update(delta: float) -> void:
	if Input.is_action_pressed("start"):
		change_state("Run")
