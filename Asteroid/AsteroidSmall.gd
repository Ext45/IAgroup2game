extends "res://Asteroid/Asteroid.gd"


func explode():
	if is_exploded:
		return
	is_exploded = true
	
	get_parent().remove_child(self)
	queue_free()
