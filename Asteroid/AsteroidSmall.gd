extends "res://Asteroid/Asteroid.gd"

func _ready() -> void:
	var main_camera = get_node("/root/World/MainCamera")
	self.connect("explode", main_camera, "asteroid_small_exploded")

func explode():
	if is_exploded:
		return
	is_exploded = true
	
	_explosion_particles()
	emit_signal("explode")
	emit_signal("score_changed", 50)
	
	get_parent().remove_child(self)
	queue_free()
