extends KinematicBody2D

signal laser_shoot(location)
signal player_died()

var player_explosion_scene = load("res://Objects/ParticlesPlayerExplosion.tscn")

export (int) var SPEED = 500

func _ready():
	var camera = get_parent().get_node("MainCamera")
	self.connect("laser_shoot", camera, "_on_Character_laser_shoot")
	
	var game = get_parent()
	self.connect("player_died", game, "_on_Character_player_died")

func _physics_process(delta: float) -> void:
	var velocity = Vector2()
	
	if (Input.is_action_pressed("up")):
		velocity.y -= SPEED
	if (Input.is_action_pressed("down")):
		velocity.y += SPEED
	
	
	move_and_collide(velocity * delta)
	

func _unhandled_key_input(event: InputEventKey) -> void:
	if (event.is_action_pressed("shoot")):
		$LaserWeapon.shoot()
		emit_signal("laser_shoot")

func _on_Hitbox_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (!self.is_queued_for_deletion() && body.is_in_group("Asteroids")):
		explode()
		queue_free()

func explode():
	var explosion = player_explosion_scene.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	explosion.emitting = true
	emit_signal("player_died")
