extends CharacterBody2D
class_name Player

@onready var front_rc: RayCast2D = $FrontRayCast
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@onready var run_particle: GPUParticles2D = $Particles/RunParticle
@onready var slide_particle: GPUParticles2D = $Particles/SlideParticle

const GRAVITY = 800
const JUMP_SPEED = -250
const MAX_JUMPS: int = 1
var jump_count: int = 0
@export var coyote_time: float = 0.15  
@export var jump_buffer_time: float = 0.1
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var jump_pressed: bool = false


@export var speed: float = 100.0
var direction: int = 1  # 1 = right, -1 = left
var isFalling: bool = false
var isSliding: bool = false


func _physics_process(delta):
	if !isFalling:
		velocity.x = direction * speed
	
	if not is_on_floor() and !isSliding:
		velocity.y += GRAVITY * delta

   # Update timers
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta
		
	if jump_pressed:
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta

	move_and_slide()

func change_dir():
	direction *= -1
	transform.x *= -1

func jump() -> bool:
	print('yahoo')
	if jump_count <= MAX_JUMPS:
		velocity.y = JUMP_SPEED
		jump_count += 1
		jump_pressed = false
		
		return true
	
	return false
	
func _input(event):
	if event.is_action_pressed("jump"):
		jump_pressed = true
		
func reset_jumps():
	jump_count = 0
