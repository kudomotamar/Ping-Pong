extends CharacterBody2D

@onready var label: Label = $"../CanvasLayer/Label"
@onready var speed_count: Label = $"../CanvasLayer/Label2"
@onready var trail: GPUParticles2D = $GPUParticles2D

@export var speed = 450

var score_left = 0
var score_right = 0

func _ready():
	velocity = Vector2(1, 0.5).normalized() * speed
	update_score()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

	trail.emitting = velocity.length() > 0

func _on_left_score_body_entered(_body: Node) -> void:
	score_left += 1
	if score_left % 5 == 0:
		speed += 10
	await get_tree().create_timer(0.2).timeout
	update_score()

func _on_right_score_body_entered(_body: Node) -> void:
	score_right += 1
	if score_right % 5 == 0:
		speed += 10
	await get_tree().create_timer(0.2).timeout
	update_score()

func update_score():
	label.text = str(score_right) + " | " + str(score_left)
	speed_count.text = str(speed)
	reset()

func reset():
	position = get_viewport_rect().size / 2
	velocity = Vector2.ZERO   # stop ball
	await get_tree().create_timer(1.0).timeout
	var x = randf_range(-1.0, 1.0)
	var y = random_y()
	velocity = Vector2(x, y).normalized() * speed

func random_y():
	if randf() < 0.5:
		return randf_range(-1.0, -0.5)
	else:
		return randf_range(0.5, 1.0)
