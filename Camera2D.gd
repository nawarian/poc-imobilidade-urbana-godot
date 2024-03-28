extends Camera2D

var player: Player

func _ready():
	player = get_node("/root/Gameplay/Player")

func _process(delta):
	position = player.global_position
