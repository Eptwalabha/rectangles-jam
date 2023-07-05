class_name UIInputs
extends Node2D

@onready var left_key: KeyboardKey = $Arrows/LeftKey
@onready var right_key: KeyboardKey = $Arrows/RightKey
@onready var space_key: KeyboardKey = $SpaceKey

var is_action_hint : bool = false
var is_direction_hint : bool = false

func set_active(is_active: bool) -> void:
	space_key.set_active(is_active)
	left_key.set_active(is_active)
	right_key.set_active(is_active)

func _process(_delta: float) -> void:
	if is_action_hint and Input.is_action_just_pressed("action"):
		is_action_hint = false
		space_key.stop_hint()

	elif is_direction_hint and Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		is_direction_hint = false
		left_key.stop_hint()
		right_key.stop_hint()

func hint_action() -> void:
	is_action_hint = true
	space_key.hint()

func hint_directions() -> void:
	is_direction_hint = true
	left_key.hint()
	right_key.hint()
