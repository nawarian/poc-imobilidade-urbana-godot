class_name Monster
extends KinematicBody2D

enum Direction {
	LEFT,
	RIGHT
}
var direction = Direction.RIGHT

var velocity = Vector2()
var speed = 300

onready var sfx_speech: AudioStreamPlayer2D = $Speech
var speech_sfx = []
var speech_sfx_frame_interval = 200
var speech_sfx_frames = 0

func _ready():
	# Load speech sounds
	speech_sfx.append(load("res://Monster/Assets/sfx/sfx_monstro_dinheiro.mp3"))
	speech_sfx.append(load("res://Monster/Assets/sfx/sfx_monstro_extremamente.mp3"))
	speech_sfx.append(load("res://Monster/Assets/sfx/sfx_monstro_privatizacao.mp3"))
	speech_sfx.append(load("res://Monster/Assets/sfx/sfx_monstro_sabesp.mp3"))
	speech_sfx.append(load("res://Monster/Assets/sfx/sfx_monstro_via_mobilidade.mp3"))

func _process(delta):
	var scale = get_scale()
	if (direction == Direction.RIGHT):
		scale.x = 1
	else:
		scale.x = -1
	set_scale(scale)

	if (!sfx_speech.playing):
		speech_sfx_frames += 1
		if (speech_sfx_frames > speech_sfx_frame_interval):
			sfx_speech.stop()
			speech_sfx_frames = 0

			var idx = randi() % speech_sfx.size()
			sfx_speech.stream = speech_sfx[idx]
			sfx_speech.play()

func _physics_process(delta):
	if (direction == Direction.RIGHT):
		velocity.x = speed * delta
	else:
		velocity.x = -speed * delta

	var collision = move_and_collide(velocity)
	if (collision):
		if (direction == Direction.LEFT):
			direction = Direction.RIGHT
		else:
			direction = Direction.LEFT
