class_name NPC
extends Character

signal target_reached

@onready var target: Marker2D = $Node/Target

func set_target(target_position: Vector2i) -> void:
	target.position = target_position
	moving = true

func _process(delta: float) -> void:
	if moving and is_target_reached():
		moving = false
		emit_signal("target_reached")

func is_target_reached() -> bool:
	return abs(target.position.x - global_position.x) <= 5
