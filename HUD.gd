extends CanvasLayer

onready var player: Player = get_node("/root/Gameplay/Player")

func _process(delta):
	$FlashlightToggleOff.visible = !player.is_flashlight_on()
	$FlashlightToggleOn.visible = player.is_flashlight_on()

func _on_FlashlightToggleOff_pressed():
	player.toggle_flashlight()

func _on_FlashlightToggleOn_pressed():
	player.toggle_flashlight()

func _on_LeftTouch_pressed():
	Input.action_press("move_left")

func _on_LeftTouch_released():
	Input.action_release("move_left")

func _on_RightTouch_pressed():
	Input.action_press("move_right")

func _on_RightTouch_released():
	Input.action_release("move_right")
