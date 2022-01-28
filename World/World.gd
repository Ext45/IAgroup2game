extends Node2D

var Laser = preload("res://Bullet/Bullet.tscn")

func _ready():
	pass


func _on_Character_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)


# Game Over
func _on_Character_player_died():
	# Stop game music, load game over music
	# Stop asteroids from spawning
	$AsteroidSpawner/SpawnTimer.stop()
	
	for a in get_tree().get_nodes_in_group("Asteroids"):
		pass
		
	$GameOverTimer.start()


func _on_GameOverTimer_timeout():
	# Play music and show screen
	$GameOverLabel.visible = true
