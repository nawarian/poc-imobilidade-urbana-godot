extends Camera2D

var player: Player

func _ready():
	player = get_node("/root/Gameplay/Player")

func _process(delta):
	position = player.global_position

func _on_LeftTouch_pressed():
	Input.action_press("move_left")

func _on_LeftTouch_released():
	Input.action_release("move_left")

func _on_RightTouch_pressed():
	Input.action_press("move_right")

func _on_RightTouch_released():
	Input.action_release("move_right")
