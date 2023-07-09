extends Node

var translations = []

func translate(object,position,time):
	var translation = {
		object = object,
		t = 0,
		start = object.position,
		target = position,
		time = time
	}
	
	translations.push_front(translation)
	
	await TimerManager.sleep(time)
	
	return
	
func _process(delta):
	for t in translations:
		if(t.object != null):
			t.object.position = lerp(t.start,t.target,t.t)
			t.t += delta / t.time
			if(t.t>1):
				t.object.position = t.target
				translations.erase(t)
		else:
			translations.erase(t)
	
