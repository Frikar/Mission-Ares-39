extends Node

var num_players = 8
var bus = "master"
var volumen = -6
var available = []  # The available players.
var queue = []  # The queue of sounds to play.


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.volume_db = volumen
		p.connect("finished", self, "_on_stream_finished", [p])
		p.bus = bus


func play(sound_path):
	queue.append(sound_path)


func _process(delta):
	# Play a queued sound if any players are available.
	if not queue.empty() and not available.empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
		
func _on_AudioStreamManager_finished(stream):
		available.append(stream)
