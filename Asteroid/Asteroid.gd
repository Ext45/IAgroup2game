extends RigidBody2D

var asteroid_small_scene = load("res://Asteroid/AsteroidSmall.tscn")
var rng = RandomNumberGenerator.new()

var is_exploded = false

func explode():
	if is_exploded:
		return
	is_exploded = true
	
	_spawn_asteroid_debris(4)
	
	get_parent().remove_child(self)
	queue_free()

func _spawn_asteroid_debris(num: int):
	for i in range(num):
		_spawn_asteroid_small()

func _spawn_asteroid_small():
	var asteroid_small = asteroid_small_scene.instance()
	asteroid_small.position = self.position
	_randomize_trajectory(asteroid_small)
	get_parent().add_child(asteroid_small)

func _randomize_trajectory(asteroid):
	# random spin
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	
	rng.randomize()
	var lv_x = rng.randi_range(-1, 1)*400
	var lv_y = rng.randi_range(-1, 1)*400
	
	asteroid.linear_velocity = Vector2(lv_x, lv_y)
	asteroid.linear_damp = 0

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
