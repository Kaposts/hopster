@tool

extends State

@export var max_slide_speed: float = 100.0
@export var slide_accel: float = 0.1
var slide_speed: float = 0
var player: Player

func _on_enter(args):
	slide_speed = 0
	player = target
	player.anim.play("slide")
	player.isSliding = true
	player.slide_particle.emitting = true
	print('state: Slide')

func _on_update(delta):
	# Apply weaker gravity when sliding
	slide_speed = lerp(slide_speed, max_slide_speed, slide_accel) 
	player.velocity.y = slide_speed
	
	if player.is_on_floor():
		player.slide_particle.emitting = false
	
	if Input.is_action_just_pressed("jump"):
		change_state("Jump")
	
	elif !player.front_rc.is_colliding():
		change_state("Fall")
		
func _on_exit(args):
	player.change_dir()
	player.isSliding = false
	player.slide_particle.emitting = false
