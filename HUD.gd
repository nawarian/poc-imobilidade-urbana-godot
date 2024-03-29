extends CanvasLayer

onready var player: Player = get_node("/root/Gameplay/Player")

onready var toggle_off: TextureButton = $FlashlightToggleOn
onready var toggle_on: TextureButton = $FlashlightToggleOn

func _process(delta):
	toggle_off.visible = !player.is_flashlight_on()
	toggle_on.visible = player.is_flashlight_on()

func _on_FlashlightToggleOff_pressed():
	player.toggle_flashlight()

func _on_FlashlightToggleOn_pressed():
	player.toggle_flashlight()
