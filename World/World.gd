extends Node2D

var Laser = preload("res://Bullet/Bullet.tscn")

func _ready():
	pass


func _on_Character_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)
