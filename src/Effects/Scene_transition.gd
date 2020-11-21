extends Area2D

export(String, FILE) var scene

func _on_Scene_transition_area_entered(area):
	print("Estoy aca")
	Transit.change_scene(scene, 0.5)
