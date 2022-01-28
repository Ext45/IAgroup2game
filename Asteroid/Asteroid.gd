extends RigidBody2D

var is_exploded = false

func explode():
	if is_exploded:
		return
	is_exploded = true
	get_parent().remove_child(self)
	queue_free()

