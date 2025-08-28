extends Node2D   # instead of CharacterBody2D

@export var speed = 600
@export var is_right = true
var rot = 0.0
var rot_speed = 0.3

func _process(delta):
	var dir = 0

	# Controls
	if is_right:
		if Input.is_action_pressed("ui_up"):
			dir -= 1
		if Input.is_action_pressed("ui_down"):
			dir += 1
		if Input.is_action_pressed("ui_left"):
			rot -= rot_speed
		if Input.is_action_pressed("ui_right"):
			rot += rot_speed
	else:
		if Input.is_action_pressed("w"):
			dir -= 1
		if Input.is_action_pressed("s"):
			dir += 1
		if Input.is_action_pressed("a"):
			rot -= rot_speed
		if Input.is_action_pressed("d"):
			rot += rot_speed

	# Move manually (no physics body pushing back)
	position.y += dir * speed * delta

	# Clamp inside screen
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)

	# Rotate paddle (affects CollisionShape2D too)
	rotation = rot
