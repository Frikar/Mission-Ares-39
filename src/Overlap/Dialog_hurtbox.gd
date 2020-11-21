extends Area2D

var Dialog = preload("res://addons/dialogs/Dialog.tscn")
var dialog = Dialog.instance()
onready var animate = $AnimatedSprite
export var label_position = Vector2(154.051, 160.901)
var read = false
export(Resource) var dialog_resource

func _on_Dialog_hurtbox_area_entered(area):
	if read == false:
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

func _on_Dialog_hurtbox_area_exited(area):
	read = true
