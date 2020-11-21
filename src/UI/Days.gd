extends Control

var modulate_max_value = 0.1
onready var screenTime = $Screen_time
onready var label = $Label
onready var label2 = $Label2
onready var fadeOut = $Fade_out

func _on_Fade_out_timeout():
	label.modulate.a -= modulate_max_value
	label2.modulate.a -= modulate_max_value
	if label2.modulate.a && label.modulate.a == 0:
		queue_free()

func _on_Screen_time_timeout():
	fadeOut.start()
