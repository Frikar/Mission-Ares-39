extends Control

onready var fadeOut = $FadeOut
onready var firstKey = $AnimatedSprite
onready var secondKey = $AnimatedSprite2
onready var screenTime = $ScreenTime
onready var label = $Label
var modulate_value = 1
var modulate_max_value = 0.1
	
func _on_ScreenTime_timeout():
	fadeOut.start()

func _on_FadeOut_timeout():
	firstKey.modulate.a -= modulate_max_value
	secondKey.modulate.a -= modulate_max_value
	label.modulate.a -= modulate_max_value
	if label.modulate.a == 0:
		queue_free()
