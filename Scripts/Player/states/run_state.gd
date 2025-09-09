@tool
extends State

var player: Player

func _on_enter(args):
	player = target
	player.anim.play("run")
	player.run_particle.emitting = true
	
	print('state: Run')
	

func _on_update(args):
	if Input.is_action_just_pressed("jump"):
		change_state("Jump")
		
	elif player.front_rc.is_colliding():
		change_state("Slide")
		
	elif !player.is_on_floor():
		change_state("Fall")
func _on_exit(args):
	player.run_particle.emitting = false
