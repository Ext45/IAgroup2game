extends Label

export (int) var LEVEL_TIME = 60

signal level_ended

func _ready():
	self.text = str(LEVEL_TIME)
	
func _on_LevelTimer_timeout():
	var time = int(text)
	time -= 1
	if (time <= 0):
		emit_signal("level_ended")
	text = str(time) 

func reset():
	text = str(LEVEL_TIME)
