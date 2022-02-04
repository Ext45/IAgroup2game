extends Control



func _ready():
	$VBoxContainer/Start.grab_focus()


func _on_Start_pressed():
	get_tree().change_scene("res://World/World.tscn")

func _on_Quit_pressed():
	get_tree().quit()


func _on_HowToPlay_pressed():
	get_tree().change_scene("res://TtileScreen/How to Play.tscn")
