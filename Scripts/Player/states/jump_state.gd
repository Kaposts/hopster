@tool
extends State

var player: Player

func _on_enter(args):
	player = target
	player.anim.play("jump")
	
  # Jump if either buffer or coyote allows it
	if player.jump_buffer_timer > 0 and player.coyote_timer > 0:
		player.jump()
		player.jump_buffer_timer = 0
		player.coyote_timer = 0
		print('hm')
		spawn_particle()
		
	print('state: Jump')

func _on_update(delta):
	if player.jump_pressed:
		player.jump()
		spawn_particle()
		if player.jump_count == 2:
			player.anim.play("double_jump")
			
	if player.is_on_floor():
		change_state("Run")
		
	elif player.front_rc.is_colliding():
		change_state("Slide")
		
	elif player.velocity.y > 0:
		player.anim.play("fall")

func spawn_particle():
	var particle: GPUParticles2D = load("res://Scenes/Particles/jump_particle.tscn").instantiate() 
	particle.emitting = true
	particle.finished.connect(func(): particle.queue_free())
	particle.position = Vector2(player.global_position.x, player.global_position.y + 15)
	player.get_parent().add_child(particle)

func _on_exit(args):
	player.reset_jumps()
