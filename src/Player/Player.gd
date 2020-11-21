extends KinematicBody2D

var velocity = Vector2.ZERO
var MAX_SPEED = 90
var FRICTION = 500
var ACCELERATION = 500
var direction = "Right"
var chain_attack = 0
var last_direction
var state
enum {
	MOVE
	ATTACK
	INTERACT
}
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var sprite = $Sprite
onready var walking_sound = $Walking_sound
onready var attack_sound1 = $Attack_sound1
onready var attack_sound2 = $Attack_sound2
onready var attack_sound3 = $Attack_sound3
onready var player_camera = $PlayerCamera
onready var animationState = animationTree.get("parameters/playback")
onready var Pause_menu = preload("res://src/UI/Pause Menu.tscn")

func _physics_process(delta):
	state = Globals.player_state
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		INTERACT:
			interact_state(delta)
	camera_change()

func move():
	velocity = move_and_slide(velocity)
	
func get_player_direction():
	if sprite.flip_h == true:
		direction = "Left"
	else:
		direction = "Right"

func get_player_animation(input_vector):
	if input_vector.x <= -0.707:
		direction = "Left"
	elif input_vector.x >= 0.707:
		direction = "Right"

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	get_player_animation(input_vector)
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animationState.travel("Run" + direction)
		if !walking_sound.playing && velocity.move_toward(Vector2.ZERO, FRICTION * delta):
			walking_sound.play()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta )
		animationState.travel("Idle" + direction)
		walking_sound.stop()
	move()
	
	if Input.is_action_just_pressed("ui_attack"):
		chain_attack += 1
		Globals.player_state = ATTACK
		attack_sound()

func attack_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	if chain_attack >= 3:
		animationState.travel("Attack3" + direction)
		chain_attack = 0
	elif chain_attack == 2:
		animationState.travel("Attack2" + direction)
	else:
		animationState.travel("Attack1" + direction)
	
	
func attack_animation_finished():
	velocity = Vector2.ZERO
	Globals.player_state = MOVE

func interact_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	animationState.travel("Idle" + direction)

func attack_sound():
	if !attack_sound3.playing && chain_attack >= 3:
		attack_sound3.play()
	elif !attack_sound2.playing && chain_attack == 2:
		attack_sound2.play()
	else:
		attack_sound1.play()

func camera_change():
	if get_tree().paused:
		player_camera.clear_current()
	elif get_tree().paused == false && Globals.game_final == false:
		player_camera.make_current()
