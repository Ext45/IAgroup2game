extends Area2D


var speed = 1000

func _physics_process(delta):
	global_position.x += speed*delta


func _on_Bullet_area_entered(area):
	pass # Replace with function body.
