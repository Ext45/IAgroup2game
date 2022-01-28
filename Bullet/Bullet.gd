extends Area2D


var speed = 1000

func _physics_process(delta):
	global_position.x += speed*delta


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Bullet_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("Asteroids")):
		body.call_deferred("explode")
		get_parent().remove_child(self)
		queue_free()
