extends Node

var tracks_number = 20
var tracks = []


func _ready():
	_create_tracks()
	
func _create_tracks():
	for i in tracks_number:
		var p = AudioStreamPlayer.new()
		add_child(p)
		tracks.append(p)
		p.volume_db = -10
		#p.finished.connect(_on_stream_finished.bind(p))
		p.bus = "master"
		
func play(audio_path_array : Array, pitch_scale = 1, volume_db = 1):
	var audio_path = audio_path_array.pick_random()
	for audio_track : AudioStreamPlayer in tracks:
		if audio_track.playing:
			continue
		else:
			audio_track.stream = load(audio_path)
			audio_track.volume_db = volume_db
			audio_track.pitch_scale = pitch_scale
			audio_track.play()


# ============================================================================
#extends Node

# Code adapted from KidsCanCode

#var num_players = 12
#var bus = "master"
#
#var available = []  # The available players.
#var queue = []  # The queue of sounds to play.

#func _ready():
	#for i in num_players:
		#var p = AudioStreamPlayer.new()
		#add_child(p)
#
		#available.append(p)
#
		#p.volume_db = -10
		#p.finished.connect(_on_stream_finished.bind(p))
		#p.bus = bus
#
#func _on_stream_finished(stream):
	#available.append(stream)
#
#func play(sound_path):  # Path (or multiple, separated by commas)
	#var sounds = sound_path.split(",")
	#queue.append("res://" + sounds[randi() % sounds.size()].strip_edges())
#
#func _process(_delta):
	#if not queue.is_empty() and not available.is_empty():
		#available[0].stream = load(queue.pop_front())
		#available[0].play()
		#available[0].pitch_scale = randf_range(0.9, 1.1)
#
		#available.pop_front()
