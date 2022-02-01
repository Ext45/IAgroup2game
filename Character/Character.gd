extends KinematicBody2D

signal laser_shoot(location)
signal player_died()

var player_explosion_scene = load("res://Objects/ParticlesPlayerExplosion.tscn")

# Dash
var DASH = 800
var DASH_DISTANCE = 100.0

var canDash = true
var isDashing = false
var dash_time = DASH_DISTANCE/DASH
var dash_timer = dash_time

export (int) var SPEED = 500

func _ready():
	var camera = get_parent().get_node("MainCamera")
	self.connect("laser_shoot", camera, "_on_Character_laser_shoot")
	
	var game = get_parent()
	self.connect("player_died", game, "_on_Character_player_died")

func _physics_process(delta: float) -> void:
	var velocity = Vector2()
	
	if isDashing:
		dash_timer += delta
	if dash_timer > dash_time:
		isDashing = false
	else:
		isDashing = true
	
	if not isDashing:
		if (Input.is_action_pressed("up")):
			velocity.y -= SPEED
		if (Input.is_action_pressed("down")):
			velocity.y += SPEED
	
	if Input.is_action_just_pressed("dash"):
		if canDash and velocity.y != 0:
			$DashTimer.start()
			$SoundPlayer2D.play()
			velocity.y *= DASH
			canDash = false
			isDashing = true
	
	if (Input.is_action_just_pressed("shoot_controller")):
		$LaserWeapon.shoot()
		emit_signal("laser_shoot")
	
	move_and_collide(velocity * delta)


func _unhandled_key_input(event: InputEventKey) -> void:
	if (event.is_action_pressed("shoot")):
		$LaserWeapon.shoot()
		emit_signal("laser_shoot")
		


func _on_Hitbox_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if (!self.is_queued_for_deletion() && body.is_in_group("Asteroids")):
		explode()
		queue_free()

func explode():
	var explosion = player_explosion_scene.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	explosion.emitting = true
	emit_signal("player_died")


func _on_DashTimer_timeout():
	canDash = true
