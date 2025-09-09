@tool
extends State

var player: Player
func _on_enter(args):
	player = target
	print('state: Idle')
	change_state(player.STATE_RUN)

func _on_update(delta: float) -> void:
	if Input.is_action_pressed(Global.INPUT_ACTION_START):
		change_state(player.STATE_RUN)
