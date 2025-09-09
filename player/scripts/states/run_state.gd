@tool
extends State

var player: Player

func _on_enter(args):
	player = target
	player.anim.play("run")
	player.run_particle.emitting = true
	
	print('state: Run')
	

func _on_update(args):
	if Input.is_action_just_pressed(Global.INPUT_ACTION_JUMP):
		change_state(player.STATE_JUMP)
		
	elif player.front_rc.is_colliding():
		change_state(player.STATE_SLIDE)
		
	elif !player.is_on_floor():
		change_state(player.STATE_FALL)
func _on_exit(args):
	player.run_particle.emitting = false
