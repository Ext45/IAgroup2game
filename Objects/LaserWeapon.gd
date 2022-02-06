extends Node2D

var laser_scene := load("res://Objects/Laser.tscn")

func shoot():
	var laser = laser_scene.instance()
	laser.global_position = self.global_position
	get_parent().get_node("Label").text = get_parent().get_parent().name
	get_parent().get_parent().add_child(laser)
