extends Popup

var selected_menu
var already_paused
onready var resume = $Button
onready var fullscreen = $Button2
onready var quit = $Button3
onready var timer = $Timer
onready var camera = $Camera2D


func _ready():
	selected_menu = 0
	change_menu_color()

func change_menu_color():
	resume.set("custom_colors/font_color",Color("ffffff"))
	fullscreen.set("custom_colors/font_color",Color("ffffff"))
	quit.set("custom_colors/font_color",Color("ffffff"))
	
	match selected_menu:
		0:
			resume.set("custom_colors/font_color",Color("16d8f8"))
		1:
			fullscreen.set("custom_colors/font_color",Color("16d8f8"))
		2:
			quit.set("custom_colors/font_color",Color("16d8f8"))

func _input(event):
	if not visible:
		if Input.is_action_just_pressed("ui_cancel"):
			# Pause game
			Globals.game_paused = get_tree().paused
			get_tree().paused = true
			camera.make_current()
			# Reset the popup
			selected_menu = 0
			change_menu_color()
			# Show popup
			popup()
	else:
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
			print(selected_menu)
			match selected_menu:
				0:
					# Resume game
					if not Globals.game_paused:
						get_tree().paused = false
					timer.start()
					camera.clear_current()
					hide()
					
				1:
					OS.window_fullscreen = !OS.window_fullscreen
				2:
					# Quit game
					get_tree().change_scene("res://src/UI/Menu.tscn")
					get_tree().paused = false
					Globals.game_paused = true


func _on_Timer_timeout():
	Globals.game_paused = true
