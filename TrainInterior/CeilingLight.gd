extends Light2D

var interval = 0

func _process(delta):
	interval += delta
	if (interval > randi() % 15):
		interval = 0
		enabled = !enabled
