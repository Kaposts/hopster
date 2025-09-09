extends CharacterBody2D
class_name Player

#region CONSTS
const STATE_IDLE = "Idle"
const STATE_RUN = "Run"
const STATE_JUMP = "Jump"
const STATE_SLIDE = "Slide"
const STATE_FALL = "Fall" 

const ANIM_IDLE = "idle"
const ANIM_RUN = "run"
const ANIM_JUMP = "jump"
const ANIM_DOUBLE_JUMP = "double_jump"
const ANIM_FALL = "fall"
const ANIM_SLIDE = "slide"
const ANIM_HIT = "hit"
#endregion

#region Player Nodes
@onready var front_rc: RayCast2D = $FrontRayCast
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var run_particle: GPUParticles2D = $Particles/RunParticle
@onready var slide_particle: GPUParticles2D = $Particles/SlideParticle
#endregion

#region Jump Variables
const GRAVITY = 800
const JUMP_SPEED = -250
const MAX_JUMPS: int = 1

var jump_count: int = 0
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var jump_pressed: bool = false
var isFalling: bool = false

@export var coyote_time: float = 0.15  
@export var jump_buffer_time: float = 0.1
#endregion

#region Move Variables
@export var speed: float = 100.0
var direction: int = 1  # 1 = right, -1 = left
#endregion

var isSliding: bool = false

func _physics_process(delta) -> void:
	if !isFalling:
		velocity.x = direction * speed
	
	if not is_on_floor() and !isSliding:
		velocity.y += GRAVITY * delta

	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta
		
	if jump_pressed:
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta

	move_and_slide()

func change_dir() -> void:
	direction *= -1
	transform.x *= -1

func jump() -> bool:
	if jump_count <= MAX_JUMPS:
		velocity.y = JUMP_SPEED
		jump_count += 1
		jump_pressed = false
		
		return true
	
	return false
	
func _input(event) -> void:
	if event.is_action_pressed(Global.INPUT_ACTION_JUMP):
		jump_pressed = true
		
func reset_jumps() -> void:
	jump_count = 0
