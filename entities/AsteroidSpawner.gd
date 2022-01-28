extends Node

var asteroid_scene = load("res://Asteroid/Asteroid.tscn")


func _ready() -> void:
	_spawn_asteroid()

func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	
	_set_asteroid_position(asteroid)
	add_child(asteroid)

func _set_asteroid_position(asteroid):
	var rect = get_viewport().size
	asteroid.position = Vector2(rect.x + 100, rand_range(0, rect.y))

func _on_SpawnTimer_timeout():
	_spawn_asteroid()
