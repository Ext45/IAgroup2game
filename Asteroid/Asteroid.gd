extends RigidBody2D

var asteroid_small_scene = load("res://Asteroid/AsteroidSmall.tscn")
var rng = RandomNumberGenerator.new()

var explosion_particles_scene = load("res://Objects/ParticlesAsteroidExplosion.tscn")
var is_exploded = false

var asteroid_s_1 = preload("res://Asteroid/Asteroid_S.png")
var asteroid_s_2 = preload("res://Asteroid/Asteroid_S.png")

signal explode
signal score_changed
var score_value = 50


func _ready() -> void:
	var main_camera = get_node("/root/World/MainCamera")
	self.connect("explode", main_camera, "asteroid_exploded")
	var label = get_tree().get_root().get_node("World/GUI/MarginContainer/HBoxContainer/Score")
	self.connect("score_changed", label, "update_score")

func explode():
	if is_exploded:
		return
	is_exploded = true
	
	_explosion_particles()
	_play_explosion_sound()
	
	emit_signal("score_changed", score_value)
	
	emit_signal("explode")
	_spawn_asteroid_debris(4)
	
	get_parent().remove_child(self)
	queue_free()

func _explosion_particles():
	var explosion_particles = explosion_particles_scene.instance()
	explosion_particles.position = self.position
	get_parent().add_child(explosion_particles)
	explosion_particles.emitting = true
	explosion_particles.get_node("ParticlesSoundWave").emitting = true

func _play_explosion_sound():
	var explosion_sound = AudioStreamPlayer2D.new()
	explosion_sound.stream = load("res://Sounds/NewExplosion2.wav")
	explosion_sound.pitch_scale = rand_range(0.7, 0.9)
	explosion_sound.position = self.position
	get_parent().add_child(explosion_sound)
	explosion_sound.play(0)

func _spawn_asteroid_debris(num: int):
	for i in range(num):
		_spawn_asteroid_small()

func _spawn_asteroid_small():
	var asteroid_small = asteroid_small_scene.instance()
	asteroid_small.position = self.position
	_pick_random_sprite(asteroid_small)
	_randomize_trajectory(asteroid_small)
	get_parent().add_child(asteroid_small)

func _pick_random_sprite(asteroid_small):
	var img
	var num = rand_range(0,2)
	if num < 1:
		img = asteroid_s_1
	elif num >= 1:
		img = asteroid_s_2
	asteroid_small.get_node("Sprite").set_texture(img)

func _randomize_trajectory(asteroid):
	# random spin
	asteroid.angular_velocity = rand_range(-1, 1)
	asteroid.angular_damp = 0
	
	rng.randomize()
	var lv_x = rng.randf_range(-1, 1)*400
	var lv_y = rng.randi_range(-1, 1)*400
	
	asteroid.linear_velocity = Vector2(lv_x, lv_y)
	asteroid.linear_damp = 0

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
