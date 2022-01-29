extends Label

export (int) var LEVEL_TIME = 30

func _on_LevelTimer_timeout():
	var time = int(text)
	time -= 1
	text = str(time)

func reset():
	text = str(LEVEL_TIME)
