extends Node2D

onready var shake_camera = $ShakeCamera
onready var shake_time = $Shake_time
onready var event_time = $Time_event
onready var start_time = $Start_event
onready var explosion = $Explosion_sound
onready var tremor = $Tremor_sound
onready var final_music = $Final_music
onready var world_music = $WorldMusic
enum {
	MOVE
	ATTACK
	INTERACT
}
var Dialog = preload("res://addons/dialogs/Dialog.tscn")
export var label_position = Vector2(154.051, 160.901)
var dialog_box
var read = false
export(Resource) var dialog_resource
export(Resource) var dialog_resource_final

func _ready():
	Globals.game_final = true


func _input(event):
	if Input.is_action_just_pressed("ui_interact") && read == false:
		if dialog_box == true:
			read = true
			chat()

func _on_Shake_time_timeout():
	shake_camera.add_trauma(0.7)


func _on_Time_event_timeout():
	shake_time.stop()
	start_time.start()

func _on_Start_event_timeout():
	tremor.stop()
	var dialog = Dialog.instance()
	dialog.dialog_resource = dialog_resource_final
	var main = get_tree().current_scene
	main.add_child(dialog)
	dialog.set_global_position(label_position)
	

func chat():
	if dialog_box == true:
		var dialog = Dialog.instance()
		#dialog.dialog_script = [
		#{'text': 'The Planet [color=#ffdb5e]ARES[/color] could hardly survive and now is abandoned, you must discover who started this or any evidence that can serve us.'},
		#{'text': 'We have no signs of organic beings on the planet, but try to be careful Argos; for weeks you will be helpless with sufficient \nsupplies.'}
		#]
		dialog.dialog_resource = dialog_resource
		var main = get_tree().current_scene
		main.add_child(dialog)
		dialog.set_global_position(label_position)
	else:
		pass

func _on_Hurtbox_area_entered(area):
	dialog_box = true

func _on_Hurtbox_area_exited(area):
	dialog_box = false

func _on_Final_hurtbox_area_entered(area):
	if read == true:
		Globals.player_state = INTERACT
		shake_time.start()
		event_time.start()
		tremor.play()
		explosion.play()
		world_music.stop()
		final_music.play()
