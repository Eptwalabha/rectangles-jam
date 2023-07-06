class_name KeyboardKey
extends Node2D

@export var current_action: TYPE = TYPE.LEFT
@export var size: int = 4

@onready var key: Node2D = $Key
@onready var top: Node2D = $Key/Top
@onready var border: Node2D = $Key/Border
@onready var background: Node2D = $Background
@onready var collision_shape: CollisionShape2D = $ClickArea/CollisionShape2D
@onready var anim: AnimationPlayer = $AnimationPlayer

var my_action: String = "move_left"

enum TYPE {
	LEFT,
	RIGHT,
	ACTION
}

func _ready() -> void:
	_set_size()
	pressed(false)
	my_action = _get_action()

func reset() -> void:
	Input.action_release(my_action)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(my_action):
		pressed(true)
	elif Input.is_action_pressed(my_action):
		top.position.y = -8
	elif Input.is_action_just_released(my_action):
		pressed(false)

func pressed(is_pressed: bool) -> void:
	if is_pressed:
		top.position.y = -8
	else:
		var t : Tween = get_tree().create_tween()
		t.tween_property(top, "position:y", -15, .1)

func hint() -> void:
	anim.play("hint")

func stop_hint() -> void:
	anim.stop()

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			Input.action_press(my_action)
		else:
			Input.action_release(my_action)

func _get_action() -> String:
	match current_action:
		TYPE.LEFT: return "move_left"
		TYPE.RIGHT: return "move_right"
		_: return "action"

func _set_size() -> void:
	background.scale.x = size + 1
	border.scale.x = size
	top.scale.x = size
	collision_shape.shape.size.x = size * 10
