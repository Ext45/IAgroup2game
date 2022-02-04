extends Node

var asteroid_scene = load("res://Asteroid/Asteroid.tscn")
var person_scene = load("res://Person/Person.tscn")
var asteroid_1 = preload("res://Asteroid/Asteroid_S.png")
var asteroid_2 = preload("res://Asteroid/Asteroid_S.png")
var _timer = null

func _ready() -> void:
	var num = rand_range(4,15)
	
	_spawn_asteroid()
	
	_timer = Timer.new()
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(num)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	
	_pick_random_sprite(asteroid)
	_set_asteroid_position(asteroid)
	_set_asteroid_trajectory(asteroid)
	add_child(asteroid)
	
	
func _pick_random_sprite(asteroid):
	var img
	var num = rand_range(0,2)
	if num < 1:
		img = asteroid_1
	elif num >= 1:
		img = asteroid_2
	asteroid.get_node("Sprite").set_texture(img)

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


func restart():
	$SpawnTimer.stop()
	_timer.stop()
	$SpawnTimer.start()
	_timer.start()
