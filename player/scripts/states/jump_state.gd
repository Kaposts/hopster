@tool
extends State

var player: Player
@export var jump_particle: PackedScene

func _ready() -> void:
	assert(jump_particle, 'Jump particle not set')

func _on_enter(args):
	player = target
	player.anim.play(player.ANIM_JUMP)
	
  # Jump if either buffer or coyote allows it
	if player.jump_buffer_timer > 0 and player.coyote_timer > 0:
		player.jump()
		player.jump_buffer_timer = 0
		player.coyote_timer = 0
		spawn_particle()
		
	print('state: Jump')

func _on_update(delta):
	if player.jump_pressed:
		player.jump()
		spawn_particle()
		if player.jump_count == 2:
			player.anim.play(player.ANIM_DOUBLE_JUMP)
			
	if player.is_on_floor():
		change_state(player.STATE_RUN)
		
	elif player.front_rc.is_colliding():
		change_state(player.STATE_SLIDE)
		
	elif player.velocity.y > 0:
		player.anim.play(player.ANIM_FALL)

func spawn_particle():
	var particle: GPUParticles2D = jump_particle.instantiate() 
	particle.emitting = true
	particle.finished.connect(func(): particle.queue_free())
	particle.position = Vector2(player.global_position.x, player.global_position.y + 15)
	player.get_parent().add_child(particle)

func _on_exit(args):
	player.reset_jumps()
