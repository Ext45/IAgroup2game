extends Node2D

var player_scene = load("res://Character/Character.tscn")
var Laser = preload("res://Objects/Laser.tscn")
var is_game_over = false


func _on_Character_laser_shoot(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)


# Game Over
func _on_Character_player_died():
	# Stop game music, load game over music
	
	$LevelTimer.stop()
	$GameOverTimer.start()


func _on_GameOverTimer_timeout():
	# Play music and show screen
	$GameOverLabel.visible = true
	$AsteroidSpawner/SpawnTimer.stop()
	is_game_over = true

func _unhandled_input(event: InputEvent):
	if (is_game_over and event.is_action_released("restart_game")):
		_restart_game()
		
func _restart_game():
	for a in get_tree().get_nodes_in_group("Asteroids"):
		a.queue_free()
	is_game_over = false
	_undo_game_over()
	_respawn_player()
	$AsteroidSpawner.restart()
	$LevelTimer.start()
	$GUI/MarginContainer/HBoxContainer/Score.reset()
	$GUI/MarginContainer/HBoxContainer/Time.reset()
	
	
func _undo_game_over():
	$GameOverLabel.visible = false
	
func _respawn_player():
	var player = player_scene.instance()
	player.position = Vector2(50, 350)
	add_child(player)
