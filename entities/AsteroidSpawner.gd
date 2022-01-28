extends Node

var asteroid_scene = load("res://Asteroid/Asteroid.tscn")


func _ready() -> void:
	_spawn_asteroid()

func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	
	_set_asteroid_position(asteroid)
	_set_asteroid_trajectory(asteroid)
	add_child(asteroid)

func _set_asteroid_position(asteroid):
	var rect = get_viewport().size
	asteroid.position = Vector2(rect.x + 100, rand_range(100, rect.y - 100))

func _set_asteroid_trajectory(asteroid):
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	asteroid.linear_velocity = Vector2(-200, rand_range(-150, 150))
	asteroid.linear_damp = 0

func _on_SpawnTimer_timeout():
	_spawn_asteroid()
