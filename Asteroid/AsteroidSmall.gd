extends "res://Asteroid/Asteroid.gd"

func _ready() -> void:
	pass

func explode():
	if is_exploded:
		return
	is_exploded = true
	
	
	emit_signal("score_changed", 50)
	
	get_parent().remove_child(self)
	queue_free()
