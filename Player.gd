extends KinematicBody2D

var speed = 200
var rotation_speed = 1.5
onready var screen_size = get_viewport_rect().size
var velocity = Vector2.ZERO
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('ui_down'):
		velocity -= transform.x * speed
	if Input.is_action_pressed('ui_up'):
		velocity += transform.x * speed
	if Input.is_action_just_pressed("fire"):
		$LaserBeam2D.is_casting = true
		yield(get_tree().create_timer(0.5), "timeout")
		$LaserBeam2D.is_casting = false


func _physics_process(delta):
	get_input()
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
