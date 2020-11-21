extends Control

var position = Vector2(154.051, 160.901)
var Dialog = preload("res://addons/dialogs/Dialog.tscn")
export(Resource) var dialog_resource

func _ready():
	var dialog = Dialog.instance()
	dialog.dialog_resource = dialog_resource
	var main = get_tree().current_scene
	main.add_child(dialog)
	dialog.set_global_position(position)
