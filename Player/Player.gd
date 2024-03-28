class_name Player
extends KinematicBody2D

# Movement
var velocity = Vector2()
var speed = 20000

enum PlayerState {
	IDLE,
	WALKING,
}
var state

var flashlight_on = false

# SFX
var sfx_player: AudioStreamPlayer2D
var walk_sfx: Array = []
var walk_sfx_frame_interval = 32
var walk_sfx_frames = 0

# Animation
enum PlayerDirection {
	LEFT,
	RIGHT,
}
var direction

func _ready():
	state = PlayerState.IDLE
	direction = PlayerDirection.RIGHT
	sfx_player = $StepsStreamPlayer
	
	# Load walking sounds
	walk_sfx.append(load("res://Player/Assets/sfx/sfx_main_passo_1.wav"))
	walk_sfx.append(load("res://Player/Assets/sfx/sfx_main_passo_2.wav"))
	walk_sfx.append(load("res://Player/Assets/sfx/sfx_main_passo_3.wav"))
	walk_sfx.append(load("res://Player/Assets/sfx/sfx_main_passo_4.wav"))
	walk_sfx.append(load("res://Player/Assets/sfx/sfx_main_passo_5.wav"))

func _process(delta):
	if (velocity.x != 0):
		state = PlayerState.WALKING
	else:
		state = PlayerState.IDLE
	
	if (velocity.x < 0):
		direction = PlayerDirection.LEFT
	elif (velocity.x > 0):
		direction = PlayerDirection.RIGHT

	if (Input.is_action_pressed("flashlight_toggle")):
		toggle_flashlight()

	update_sfx()
	update_animation()

func _physics_process(delta):
	if (Input.is_action_pressed("move_left")):
		velocity.x = -speed * delta
	elif (Input.is_action_pressed("move_right")):
		velocity.x = speed * delta
	else:
		velocity = Vector2()

	velocity = move_and_slide(velocity)

func update_sfx():
	if (state != PlayerState.WALKING || walk_sfx.size() == 0):
		return

	walk_sfx_frames += 1
	if (walk_sfx_frames > walk_sfx_frame_interval):
		sfx_player.stop()
		walk_sfx_frames = 0

		var idx = randi() % walk_sfx.size()
		sfx_player.stream = walk_sfx[idx]
		sfx_player.play()


func update_animation():
	if (direction == PlayerDirection.LEFT && !$AnimatedSprite.flip_h):
		$AnimatedSprite.flip_h = true
		$FlashlightSource.position.x = -52
		$FlashlightRay.position.x = -426
		$FlashlightRay.position.y = -18
		$FlashlightRay.rotation_degrees = 180
	elif (direction == PlayerDirection.RIGHT && $AnimatedSprite.flip_h):
		$AnimatedSprite.flip_h = false
		$FlashlightSource.position.x = 52
		$FlashlightRay.position.x = 426
		$FlashlightRay.position.y = -5
		$FlashlightRay.rotation_degrees = 0

	match state:
		PlayerState.IDLE:
			$AnimatedSprite.play("idle")
			$AnimatedSprite.speed_scale = 1
		PlayerState.WALKING:
			$AnimatedSprite.play("walk")
			$AnimatedSprite.speed_scale = 1.8

func toggle_flashlight():
	if (!$LightStreamPlayer.playing):
		flashlight_on = !flashlight_on
		$FlashlightSource.enabled = !$FlashlightSource.enabled
		$FlashlightRay.enabled = !$FlashlightRay.enabled
		$LightStreamPlayer.play()

func is_flashlight_on():
	return flashlight_on
