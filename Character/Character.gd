extends KinematicBody2D

signal spawn_laser(location)

onready var muzzle = $Muzzle

export (int) var acceleration = 400
export (int) var max_speed = 500
var input_vector = Vector2()
var velocity = Vector2()

var rotation_dir : int
export (float) var rotation_speed = 3.5
export (float) var friction = 0.05

func _physics_process(delta):
	input_vector.y = -Input.get_action_strength("move_up") + Input.get_action_strength("move_down")
	rotation_dir = 0
#	if Input.is_action_pressed("rotate_cw"):
#		rotation_dir += 1
#	if Input.is_action_pressed("rotate_ccw"):
#		rotation_dir += -1
	
	velocity += Vector2(0, input_vector.y * acceleration * delta)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	
	if input_vector.y == 0 && velocity != Vector2.ZERO:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	
	
#	rotation += rotation_dir * rotation_speed * delta
	move_and_slide(velocity)
	
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()

func shoot_laser():
	emit_signal("spawn_laser", muzzle.global_position)
