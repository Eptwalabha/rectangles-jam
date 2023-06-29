@tool
class_name NPC
extends Character

signal target_reached

@onready var idle: Timer = $Idle

@export var target : int = 0
var from : int = 0
var to : int = 1000
var random_move: bool = false

func set_target(p_target: int) -> void:
	target = p_target
	moving = true

func move_to(target_x: int) -> void:
	set_target(target_x)
	random_move = false
	idle.stop()

func _process(delta: float) -> void:
	if not moving:
		return
	position.x += delta * speed * signf(target - position.x)

	if moving and is_target_reached():
		moving = false
		if random_move:
			wait_random()
		else:
			emit_signal("target_reached")

func wait_random() -> void:
	moving = false
	idle.start(1.0 + randf() * 3.5)

func is_target_reached() -> bool:
	return moving and abs(target - position.x) <= 5

func random_move_from_to(p_from: int, p_to: int) -> void:
	random_move = true
	from = p_from
	to = p_to
	modulate.a = 1.0
	set_target(_random_small_target())
#	wait_random()

func _random_target() -> int:
	return from + randi() % (to - from)

func _random_small_target() -> int:
	var amount : int = randi() % 100 + 50
	var direction : int = int(1 if randf() < .5 else -1)
	return mini(to, maxi(from, position.x + amount * direction))

func _on_idle_timeout() -> void:
	if random_move:
		set_target(_random_small_target())

