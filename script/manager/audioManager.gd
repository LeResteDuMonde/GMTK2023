extends Node

var sound_r = preload("res://scenes/Sound.tscn")

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
