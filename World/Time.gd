extends Label



func _on_LevelTimer_timeout():
	var time = int(text)
	time -= 1
	text = str(time)
