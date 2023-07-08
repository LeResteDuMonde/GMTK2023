extends Node

@onready var musicPlayer = get_tree().get_root().get_node("Main/Music")
var sound_r = preload("res://scenes/Sound.tscn")
var music = preload("res://audio/musics/gmtk2023Ost1.wav")
#var musicBus = AudioServer.get_bus_index("Music")
#var musicPitchEffect = AudioServer.get_bus_effect(musicBus, 0)

func start_game_music():
	musicPlayer.stream = music
	musicPlayer.play()
	
func set_music_speed(speed):
	pass
	#musicPlayer.pitch_scale = 1
	#musicPitchEffect.pitch_scale = 0.1

func play(clip_name, count = 1, time = 0,db = 1):
	var s = sound_r.instantiate()
	add_child(s)
	
	var clip = "res://audio/" + clip_name + ".wav"
	
	if(count > 1):
		var clips = []
		for i in range(count):
			clips.append(clip_name + str(i+1))
		clip = "res://audio/" + clips.pick_random() + ".wav"
		
	s.play_clip(clip, time)
	s.volume_db = db
	
	return s
