@tool
extends State

var player: Player

func _on_enter(args):
	player = target
	player.isFalling = true
	player.anim.play(player.ANIM_FALL)
	print('state: Fall')

func _on_update(delta: float) -> void:
	if Input.is_action_just_pressed(Global.INPUT_ACTION_JUMP):
		change_state(player.STATE_JUMP)
	
	elif player.is_on_floor():
		change_state(player.STATE_RUN)
		
	elif player.front_rc.is_colliding():
		change_state(player.STATE_SLIDE)
		
func _on_exit(args):
	player.isFalling = false
