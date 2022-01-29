extends "res://Asteroid/Asteroid.gd"

func _ready() -> void:
	var main_camera = get_node("/root/World/MainCamera")
	self.connect("explode", main_camera, "asteroid_small_exploded")

func explode():
	if is_exploded:
		return
	is_exploded = true
	
	_explosion_particles()
	_play_explosion_sound()
	emit_signal("explode")
	emit_signal("score_changed", 50)
	
	get_parent().remove_child(self)
	queue_free()

func _play_explosion_sound():
	var explosion_sound = AudioStreamPlayer2D.new()
	explosion_sound.stream = load("res://Sounds/Explosion1.wav")
	explosion_sound.pitch_scale = rand_range(1, 1.4)
	explosion_sound.position = self.position
	get_parent().add_child(explosion_sound)
	explosion_sound.play(0)
