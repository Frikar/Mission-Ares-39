extends Control

var selected_menu
onready var Fullscreen = $Fullscreen/Label
onready var Start = $Start/Label
onready var Quit = $Quit/Label
onready var thanks = $Thanks


func _ready():
	selected_menu = 0
	change_menu_color()
	if Globals.game_final == true:
		thanks.visible
	else:
		thanks.visible = false

func change_menu_color():
	Fullscreen.set("custom_colors/font_color",Color("ffffff"))
	Start.set("custom_colors/font_color",Color("ffffff"))
	Quit.set("custom_colors/font_color",Color("ffffff"))
	
	match selected_menu:
		0:
			Start.set("custom_colors/font_color",Color("16d8f8"))
		1:
			Fullscreen.set("custom_colors/font_color",Color("16d8f8"))
		2:
			Quit.set("custom_colors/font_color",Color("16d8f8"))

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 3;
			change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
				selected_menu = selected_menu - 1
		else:
				selected_menu = 2
		change_menu_color()
	elif Input.is_action_just_pressed("ui_interact") or Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				Globals.game_final = false
				Transit.change_scene("res://src/Cinematics/Intro.tscn")
			1:
				OS.window_fullscreen = !OS.window_fullscreen
			2:
				get_tree().quit()

