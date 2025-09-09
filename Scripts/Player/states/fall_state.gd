@tool
extends State

var player: Player

func _on_enter(args):
	player = target
	player.isFalling = true
	player.anim.play("fall")
	print('state: Fall')

func _on_update(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		change_state("Jump")
	
	elif player.is_on_floor():
		change_state("Run")
		
	elif player.front_rc.is_colliding():
		change_state("Slide")
func _on_exit(args):
	player.isFalling = false
	
