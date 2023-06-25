class_name Player
extends Character

func _ready() -> void:
	moving = false

func _process(delta: float) -> void:
	if not moving:
		pass
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("move_right"):
		position.x += speed * delta
