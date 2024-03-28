extends CanvasLayer

onready var player: Player = get_node("/root/Gameplay/Player")

func _process(delta):
	$FlashlightToggleOff.visible = !player.is_flashlight_on()
	$FlashlightToggleOn.visible = player.is_flashlight_on()

func _on_FlashlightToggle_pressed():
	player.toggle_flashlight()
