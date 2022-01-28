extends KinematicBody2D

signal spawn_laser(location)

onready var muzzle = $Muzzle

export (int) var SPEED = 500

export (float) var friction = 0.05

func _physics_process(delta: float) -> void:
	var velocity = Vector2()
#	input_vector.y = -Input.get_action_strength("move_up") + Input.get_action_strength("move_down")
#	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
#
#	velocity += Vector2(input_vector.x * acceleration, input_vector.y * acceleration)
#	velocity.x = clamp(velocity.x, -max_speed, max_speed)
#	velocity.y = clamp(velocity.y, -max_speed, max_speed)
#
#	if input_vector.y == 0 && velocity != Vector2.ZERO:
#		velocity = lerp(velocity, Vector2.ZERO, friction)
#	if input_vector.y == 0 && velocity != Vector2.ZERO:
#		velocity = lerp(velocity, Vector2.ZERO, friction)
	
	if (Input.is_action_pressed("left")):
		velocity.x -= SPEED
	if (Input.is_action_pressed("right")):
		velocity.x += SPEED
	if (Input.is_action_pressed("up")):
		velocity.y -= SPEED
	if (Input.is_action_pressed("down")):
		velocity.y += SPEED
	
	
	move_and_collide(velocity * delta)
	
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()

func shoot_laser():
	emit_signal("spawn_laser", muzzle.global_position)
