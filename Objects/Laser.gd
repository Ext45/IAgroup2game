extends Area2D


var speed = 1000

func _ready():
	$AudioStreamPlayer2D.pitch_scale = rand_range(0.8, 1)

func _process(delta):
	global_position.x += speed*delta


func _on_VisibilityNotifier2D_viewport_exited():
	queue_free()


func _on_Bullet_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (!self.is_queued_for_deletion() && body.is_in_group("Asteroids")):
		body.call_deferred("explode")
		get_parent().call_deferred("remove_child", self)
		queue_free()
